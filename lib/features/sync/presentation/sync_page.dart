import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/widgets/qr_scanner_widget.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/services/sync_token_service.dart';
import 'package:intl/intl.dart';

@RoutePage()
class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isManualEntryVisible = false;
  bool _isScannerActive = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<SyncBloc>().add(const SyncEvent.historyLoaded());
    context.read<SyncBloc>().add(const SyncEvent.tokenStatusLoaded());
    context.read<SyncBloc>().add(const SyncEvent.checkConnectionValidity());
  }

  void _showSyncAuthErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sync Authentication Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncBloc, SyncState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status is SyncStatus,
      listener: (context, state) {
        state.status.maybeWhen(
          failure: (error) {
            if (error.toLowerCase().contains('authentication failed') ||
                error.toLowerCase().contains('sync token may have expired')) {
              _showSyncAuthErrorDialog(
                  'Authentication failed. Your sync token may have expired or been revoked. Please generate a new QR code and try again.');
            }
          },
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => context.closeKeyboard(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.syncTitle),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.sync), text: 'Connection'),
                Tab(icon: Icon(Icons.qr_code_scanner), text: 'Add Token'),
                Tab(icon: Icon(Icons.history), text: 'History'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildConnectionTab(),
              _buildAddTokenTab(),
              _buildHistoryTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionTab() {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<SyncBloc>().add(const SyncEvent.checkTokenStatus());
            context
                .read<SyncBloc>()
                .add(const SyncEvent.checkConnectionValidity());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(Insets.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConnectionValidityIndicator(context, state),
                const SizedBox(height: Insets.small),
                _buildConnectionStatus(state),
                const SizedBox(height: Insets.large),
                if (state.currentToken != null) ...[
                  _buildCurrentTokenCard(state.currentToken!),
                  const SizedBox(height: Insets.large),
                ],
                _buildQuickActions(state),
                const SizedBox(height: Insets.large),
                _buildAllTokensList(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConnectionValidityIndicator(
      BuildContext context, SyncState state) {
    Widget icon;
    String text;
    Color color;

    if (state.connectionValid == null) {
      icon = const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
      text = 'Checking connection...';
      color = Colors.amber;
    } else if (state.connectionValid == true) {
      icon = const Icon(Icons.check_circle, color: Colors.green, size: 24);
      text = 'Connection to server is valid';
      color = Colors.green;
    } else {
      icon = const Icon(Icons.cancel, color: Colors.red, size: 24);
      color = Colors.red;
      text = 'Cannot connect to server'; // Default text
      state.tokenStatus.maybeWhen(
        expired: () {
          text = 'Connection Expired: Invalid Token';
        },
        orElse: () {},
      );
      state.status.maybeWhen(
        failure: (error) {
          text = 'Connection Failed: $error';
        },
        orElse: () {},
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Insets.normal, vertical: Insets.small),
        child: Row(
          children: [
            icon,
            const SizedBox(width: Insets.normal),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Check Connection',
              onPressed: () {
                context
                    .read<SyncBloc>()
                    .add(const SyncEvent.checkConnectionValidity());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus(SyncState state) {
    final token = state.currentToken;
    IconData statusIcon;
    Color statusColor;
    String statusText;
    String statusSubtext;

    if (token == null) {
      statusIcon = Icons.sync_disabled;
      statusColor = Colors.grey;
      statusText = 'Not Connected';
      statusSubtext = 'Scan a QR code to connect to your health server';
    } else if (token.isExpired) {
      statusIcon = Icons.sync_problem;
      statusColor = Colors.red;
      statusText = 'Connection Expired';
      statusSubtext = 'Token expired ${token.formattedExpiration}';
    } else if (token.isExpiringSoon) {
      statusIcon = Icons.warning;
      statusColor = Colors.orange;
      statusText = 'Connection Expiring Soon';
      statusSubtext = token.formattedExpiration;
    } else {
      statusIcon = Icons.sync;
      statusColor = Colors.green;
      statusText = 'Connected';
      statusSubtext = 'Connected to ${token.serverName}';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor, size: 32),
            const SizedBox(width: Insets.normal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    statusSubtext,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (token != null) _buildQualityIndicator(token.quality),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityIndicator(SyncTokenQuality quality) {
    Color color;
    String label;
    IconData icon;

    switch (quality) {
      case SyncTokenQuality.excellent:
        color = Colors.green;
        label = 'Excellent';
        icon = Icons.wifi;
        break;
      case SyncTokenQuality.good:
        color = Colors.lightGreen;
        label = 'Good';
        icon = Icons.wifi;
        break;
      case SyncTokenQuality.fair:
        color = Colors.orange;
        label = 'Fair';
        icon = Icons.wifi_2_bar;
        break;
      case SyncTokenQuality.poor:
        color = Colors.red;
        label = 'Poor';
        icon = Icons.wifi_1_bar;
        break;
      case SyncTokenQuality.critical:
        color = Colors.red[900]!;
        label = 'Critical';
        icon = Icons.signal_wifi_0_bar;
        break;
      case SyncTokenQuality.invalid:
        color = Colors.grey;
        label = 'Invalid';
        icon = Icons.wifi_off;
        break;
    }

    return Tooltip(
      message: label,
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildCurrentTokenCard(SyncToken token) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.computer, color: Colors.blue[600]),
                const SizedBox(width: Insets.small),
                Expanded(
                  child: Text(
                    'Current Connection',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showTokenOptions(context, token),
                ),
              ],
            ),
            const SizedBox(height: Insets.small),
            _buildTokenDetails(token),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenDetails(SyncToken token) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Server', token.serverName),
        _buildDetailRow('Address', '${token.address}:${token.port}'),
        _buildDetailRow('Token ID', token.shortId),
        _buildDetailRow('Status', token.statusDescription),
        _buildDetailRow('Expires', token.formattedExpiration),
        if (token.lastUsedAt != null)
          _buildDetailRow('Last Used', token.formattedLastUsed!),
        _buildDetailRow(
            'Created', DateFormat.yMd().add_jm().format(token.createdAt)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.extraSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(SyncState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Insets.normal),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: state.currentToken != null
                    ? () =>
                        context.read<SyncBloc>().add(const SyncEvent.syncData())
                    : null,
                icon: const Icon(Icons.sync),
                label: const Text('Sync Now'),
              ),
            ),
            const SizedBox(width: Insets.normal),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _tabController.animateTo(1),
                icon: const Icon(Icons.add),
                label: const Text('Add Token'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAllTokensList(SyncState state) {
    return FutureBuilder<List<SyncToken>>(
      future: context.read<SyncTokenService>().getAllTokens(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tokens = snapshot.data!;
        if (tokens.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(Insets.large),
              child: Column(
                children: [
                  Icon(Icons.sync_disabled, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: Insets.normal),
                  Text(
                    'No sync tokens found',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: Insets.small),
                  Text(
                    'Scan a QR code to connect to your health server',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Tokens (${tokens.length})',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Insets.normal),
            ...tokens.map((token) => _buildTokenListItem(token)),
          ],
        );
      },
    );
  }

  Widget _buildTokenListItem(SyncToken token) {
    final isCurrentToken =
        context.read<SyncBloc>().state.currentToken?.tokenId == token.tokenId;

    return Card(
      margin: const EdgeInsets.only(bottom: Insets.small),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCurrentToken ? Colors.blue : Colors.grey,
          child: Icon(
            isCurrentToken ? Icons.sync : Icons.computer,
            color: Colors.white,
          ),
        ),
        title: Text(
          token.serverName,
          style: TextStyle(
            fontWeight: isCurrentToken ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${token.address}:${token.port} • ${token.shortId}'),
            Text(
              '${token.statusDescription} • ${token.formattedExpiration}',
              style: TextStyle(
                color: token.isExpired ? Colors.red : Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQualityIndicator(token.quality),
            const SizedBox(width: Insets.small),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showTokenOptions(context, token),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildAddTokenTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Insets.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Column(
                children: [
                  Icon(Icons.qr_code_scanner,
                      size: 64, color: Colors.blue[600]),
                  const SizedBox(height: Insets.normal),
                  Text(
                    'Scan QR Code',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Insets.small),
                  Text(
                    'Scan the QR code from your Fasten Health server to create a new sync connection.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Insets.large),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isScannerActive = true;
                        });
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Start Scanner'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Insets.large),
          if (_isScannerActive)
            QRScannerWidget(
              onQRCodeDetected: (qrCode) {
                setState(() {
                  _isScannerActive = false;
                });
                context
                    .read<SyncBloc>()
                    .add(SyncEvent.syncDataWithJson(qrCode));
              },
              onCancel: () {
                setState(() {
                  _isScannerActive = false;
                });
              },
              title: 'Scan QR Code',
              cancelButtonText: 'Cancel',
            ),
          _buildManualEntrySection(),
        ],
      ),
    );
  }

  Widget _buildManualEntrySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manual Entry',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Insets.normal),
            Text(
              'If you can\'t scan the QR code, you can manually paste the sync data:',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: Insets.normal),
            const SizedBox(height: Insets.normal),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Paste sync data here',
                border: OutlineInputBorder(),
                hintText: '{"token":"...","port":"..."}',
              ),
              maxLines: 6,
            ),
            const SizedBox(height: Insets.normal),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    context
                        .read<SyncBloc>()
                        .add(SyncEvent.syncDataWithJson(_controller.text));
                    _controller.clear();
                  }
                },
                child: const Text('Connect'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sync History',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Insets.normal),
              if (state.history.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Insets.large),
                    child: Column(
                      children: [
                        Icon(Icons.history, size: 48, color: Colors.grey[400]),
                        const SizedBox(height: Insets.normal),
                        Text(
                          'No sync history',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: Insets.small),
                        Text(
                          'Sync history will appear here after your first sync',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...state.history.map((dateTime) => Card(
                      margin: const EdgeInsets.only(bottom: Insets.small),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.sync, color: Colors.green[600]),
                        ),
                        title: Text('Data Synchronized'),
                        subtitle:
                            Text(DateFormat.yMd().add_jm().format(dateTime)),
                        trailing: Text(
                          _getRelativeTime(dateTime),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays != 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours != 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes != 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  void _showTokenOptions(BuildContext context, SyncToken token) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Token Details'),
              onTap: () {
                Navigator.pop(context);
                _showTokenDetails(context, token);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Set as Current'),
              enabled: context.read<SyncBloc>().state.currentToken?.tokenId !=
                  token.tokenId,
              onTap: () {
                Navigator.pop(context);
                context.read<SyncTokenService>().saveToken(token);
                context
                    .read<SyncBloc>()
                    .add(const SyncEvent.tokenStatusLoaded());
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red[600]),
              title: Text('Revoke Token',
                  style: TextStyle(color: Colors.red[600])),
              onTap: () {
                Navigator.pop(context);
                _showRevokeTokenDialog(context, token);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showTokenDetails(BuildContext context, SyncToken token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Token Details'),
        content: SingleChildScrollView(
          child: _buildTokenDetails(token),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showRevokeTokenDialog(BuildContext context, SyncToken token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Token'),
        content: Text(
          'Are you sure you want to revoke this sync token?\n\n'
          'Server: ${token.serverName}\n'
          'Token ID: ${token.shortId}\n\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<SyncBloc>()
                  .add(SyncEvent.tokenRevoked(tokenId: token.tokenId));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
