import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/utils/date_format_utils.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/presentation/widgets/qr_scanner_widget.dart';

@RoutePage()
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasten Sync'),
        backgroundColor: context.colorScheme.inversePrimary,
      ),
      body: _buildQRCodeTab(context),
    );
  }

  Widget _buildQRCodeTab(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        // When QR scanning is active, show only the scanner
        if (state.isQRScanning) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildQRScannerSection(context, state),
          );
        }

        // Otherwise show the full sync page content
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status Card
                _buildStatusCard(context, state),
                const SizedBox(height: 16),

                // QR Scanner Section
                _buildQRScannerSection(context, state),
                const SizedBox(height: 16),

                // QR Configuration Display
                if (state.syncToken != null) ...[
                  _buildQRConfigCard(context, state),
                  const SizedBox(height: 16),
                ],

                // Error Display
                if (state.qrError != null) ...[
                  _buildErrorDisplay(context, state),
                  const SizedBox(height: 16),
                ],

                // Success Display
                if (state.successMessage != null) ...[
                  _buildSuccessDisplay(context, state),
                  const SizedBox(height: 16),
                ],

                // Action Buttons
                _buildQRActionButtons(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(BuildContext context, SyncState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sync Status',
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildStatusIndicator(context, state),
                const SizedBox(width: 8),
                Text(
                  _getStatusText(context, state),
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
            if (state.syncToken != null) ...[
              const SizedBox(height: 8),
              Text(
                'Connected to: ${state.syncToken!.address}:${state.syncToken!.port}',
                style: context.textTheme.bodyMedium,
              ),
            ],
            if (state.lastSyncTime != null) ...[
              const SizedBox(height: 8),
              Text(
                'Last sync: ${DateFormatUtils.humanReadable(state.lastSyncTime!)}',
                style: context.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getStatusText(BuildContext context, SyncState state) {
    // Check if we have a valid token first using BLoC
    final hasValidToken = context.read<SyncBloc>().isCurrentTokenValid();

    if (hasValidToken) {
      if (state.syncStatus == SyncStatus.connected) {
        return 'Connected and ready to sync';
      } else if (state.syncStatus == SyncStatus.syncing) {
        return 'Syncing...';
      } else if (state.syncStatus == SyncStatus.synced) {
        return 'Sync completed successfully';
      } else if (state.syncStatus == SyncStatus.connecting) {
        return 'Connecting...';
      } else if (state.syncStatus == SyncStatus.error) {
        return 'Connection error';
      } else {
        return 'Token valid, ready to connect';
      }
    } else {
      switch (state.syncStatus) {
        case SyncStatus.disconnected:
          return 'Ready to scan QR code';
        case SyncStatus.connecting:
          return 'Connecting...';
        case SyncStatus.connected:
          return 'Connected';
        case SyncStatus.syncing:
          return 'Syncing...';
        case SyncStatus.synced:
          return 'Sync completed';
        case SyncStatus.error:
          return 'Error';
      }
    }
  }

  Widget _buildStatusIndicator(BuildContext context, SyncState state) {
    Color color;
    IconData icon;

    // Check if we have a valid token using BLoC
    final hasValidToken = context.read<SyncBloc>().isCurrentTokenValid();

    if (hasValidToken) {
      switch (state.syncStatus) {
        case SyncStatus.connected:
          color = Colors.green;
          icon = Icons.check_circle;
          break;
        case SyncStatus.syncing:
          color = Colors.blue;
          icon = Icons.sync;
          break;
        case SyncStatus.synced:
          color = Colors.green;
          icon = Icons.check_circle_outline;
          break;
        case SyncStatus.connecting:
          color = Colors.orange;
          icon = Icons.sync;
          break;
        case SyncStatus.error:
          color = Colors.red;
          icon = Icons.error;
          break;
        case SyncStatus.disconnected:
          color = Colors.orange;
          icon = Icons.pending;
          break;
      }
    } else {
      switch (state.syncStatus) {
        case SyncStatus.disconnected:
          color = Colors.grey;
          icon = Icons.qr_code_scanner_outlined;
          break;
        case SyncStatus.connecting:
          color = Colors.orange;
          icon = Icons.sync;
          break;
        case SyncStatus.connected:
          color = Colors.green;
          icon = Icons.check_circle;
          break;
        case SyncStatus.syncing:
          color = Colors.blue;
          icon = Icons.sync;
          break;
        case SyncStatus.synced:
          color = Colors.green;
          icon = Icons.check_circle_outline;
          break;
        case SyncStatus.error:
          color = Colors.red;
          icon = Icons.error;
          break;
      }
    }

    return Icon(icon, color: color, size: 20);
  }

  Widget _buildQRScannerSection(BuildContext context, SyncState state) {
    if (state.isQRScanning) {
      return QRScannerWidget(
        title: 'Scan QR Code',
        cancelButtonText: 'Cancel',
        onQRCodeDetected: (qrData) {
          context.read<SyncBloc>().add(SyncProcessQRCode(qrData));
        },
        onCancel: () {
          context.read<SyncBloc>().add(const SyncCancelQRScanning());
        },
      );
    }

    // Hide scanner section if we already have a valid token
    if (context.read<SyncBloc>().isCurrentTokenValid()) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QR Code Scanner',
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Scan a QR code from your Fasten server to establish a secure connection.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<SyncBloc>().add(const SyncScanQRCode());
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan QR Code'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.isDarkMode
                      ? Colors.white
                      : context.colorScheme.onPrimary,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Development: Manual QR Code Input
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Development: Manual Input',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showManualQRInput(context),
                icon: const Icon(Icons.edit),
                label: const Text('Enter QR Data Manually'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.isDarkMode
                      ? Colors.white
                      : context.colorScheme.primary,
                  side: BorderSide(color: context.colorScheme.primary),
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRConfigCard(BuildContext context, SyncState state) {
    final token = state.syncToken!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Server Configuration',
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Server',
                '${token.protocol}://${token.address}:${token.port}'),
            _buildDetailRow(context, 'Expires',
                context.read<SyncBloc>().getTokenExpirationDescription()),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.read<SyncBloc>().isCurrentTokenValid()
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: context.read<SyncBloc>().isCurrentTokenValid()
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              child: Text(
                context.read<SyncBloc>().isCurrentTokenValid()
                    ? 'Valid'
                    : 'Expired',
                style: TextStyle(
                  color: context.read<SyncBloc>().isCurrentTokenValid()
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurface.withOpacity(0.85),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorDisplay(BuildContext context, SyncState state) {
    return Card(
      color: Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state.qrError!,
                style: TextStyle(
                  color: Colors.red[700],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SyncBloc>().add(const SyncClearError());
              },
              icon: const Icon(Icons.close, color: Colors.red),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessDisplay(BuildContext context, SyncState state) {
    return Card(
      color: Colors.green.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state.successMessage!,
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SyncBloc>().add(const SyncClearSuccess());
              },
              icon: const Icon(Icons.close, color: Colors.green),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRActionButtons(BuildContext context, SyncState state) {
    if (state.syncToken == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Show connecting status when auto-connecting
        if (state.syncStatus == SyncStatus.connecting) ...[
          Card(
            color: Colors.orange.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Connecting to server...',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Show sync data button when token is valid (regardless of connection status)
        if (context.read<SyncBloc>().isCurrentTokenValid()) ...[
          Card(
            color: Colors.green.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Token is valid! You can sync your data.',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state.syncStatus != SyncStatus.connected) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Note: Connection status: ${_getStatusText(context, state)}',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Show connection status when connected but not ready
          if (state.syncStatus == SyncStatus.connected &&
              state.workingBaseUrl == null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Server connected but not ready for sync. Please wait...',
                      style: TextStyle(color: Colors.orange[700], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Main Sync Data button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (state.workingBaseUrl == null) {
                        // If not connected, trigger connection
                        context.read<SyncBloc>().add(const SyncConnectWithQR());
                      } else {
                        // If connected, trigger sync
                        context.read<SyncBloc>().add(const SyncData());
                      }
                    },
              icon: state.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.sync, size: 24),
              label: Text(
                state.isLoading
                    ? 'Syncing...'
                    : (state.workingBaseUrl == null
                        ? 'Connect First'
                        : 'Sync Data'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.isDarkMode
                    ? Colors.white
                    : context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Show help text when sync button is disabled
          if (state.workingBaseUrl == null &&
              state.syncStatus == SyncStatus.connected) ...[
            const SizedBox(height: 8),
            Text(
              '💡 Tip: Click "Connect" first to establish a working connection, then sync your data.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ] else ...[
            const SizedBox(height: 12),
          ],
          // Secondary buttons row
          Row(
            children: [
              // Only show disconnect button when actually connected
              if (state.syncStatus == SyncStatus.connected &&
                  state.workingBaseUrl != null) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<SyncBloc>().add(const SyncDisconnectQR());
                    },
                    icon: const Icon(Icons.power_off),
                    label: const Text('Disconnect'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.isDarkMode
                          ? Colors.white
                          : context.colorScheme.primary,
                      side: BorderSide(color: context.colorScheme.primary),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
              // Show reset button when sync is completed
              if (state.syncStatus == SyncStatus.synced) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<SyncBloc>().add(const SyncResetStatus());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Status'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.isDarkMode
                          ? Colors.white
                          : context.colorScheme.primary,
                      side: BorderSide(color: context.colorScheme.primary),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              context.read<SyncBloc>().add(const SyncClearToken());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Scan New QR Code'),
            style: OutlinedButton.styleFrom(
              foregroundColor: context.isDarkMode
                  ? Colors.white
                  : context.colorScheme.primary,
              side: BorderSide(color: context.colorScheme.primary),
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showManualQRInput(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter QR Code Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Paste the raw QR code data (JSON format):',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '{"token": "...", "server": {...}, ...}',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: context.isDarkMode
                    ? Colors.white
                    : context.colorScheme.primary,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final qrData = controller.text.trim();
                if (qrData.isNotEmpty) {
                  context.read<SyncBloc>().add(SyncProcessQRCode(qrData));
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.isDarkMode
                    ? Colors.white
                    : context.colorScheme.onPrimary,
              ),
              child: const Text('Process'),
            ),
          ],
        );
      },
    );
  }
}
