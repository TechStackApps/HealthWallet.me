import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/utils/date_format_utils.dart';
import 'package:intl/intl.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';

@RoutePage()
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the globally provided SyncBloc from the app-level MultiBlocProvider
    return const SyncView();
  }
}

class SyncView extends StatelessWidget {
  const SyncView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasten Sync'),
        backgroundColor: context.colorScheme.inversePrimary,
      ),
      body: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Status Card
                  _buildStatusCard(context, state),
                  const SizedBox(height: 16),

                  // Service Discovery
                  _buildServiceDiscovery(context, state),
                  const SizedBox(height: 16),

                  // Error is shown contextually under each service tile only

                  const SizedBox(height: 32), // Add bottom padding for scroll
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build detail rows
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
                _buildStatusIndicator(state.syncStatus),
                const SizedBox(width: 8),
                Text(
                  _getStatusText(state.syncStatus),
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
            if (state.connectedService != null) ...[
              const SizedBox(height: 8),
              Text(
                'Connected to: ${state.connectedService!.friendlyName}',
                style: context.textTheme.bodyMedium,
              ),
            ] else if (state.discoveredServices.isEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Ready to scan for Fasten servers',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
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

  Widget _buildStatusIndicator(SyncStatus status) {
    Color color;
    IconData icon;

    switch (status) {
      case SyncStatus.disconnected:
        color = Colors.grey;
        icon = Icons.circle_outlined;
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
      case SyncStatus.error:
        color = Colors.red;
        icon = Icons.error;
        break;
    }

    return Icon(icon, color: color, size: 20);
  }

  String _getStatusText(SyncStatus status) {
    switch (status) {
      case SyncStatus.disconnected:
        return 'Disconnected';
      case SyncStatus.connecting:
        return 'Connecting...';
      case SyncStatus.connected:
        return 'Connected';
      case SyncStatus.syncing:
        return 'Syncing...';
      case SyncStatus.error:
        return 'Error';
    }
  }

  Widget _buildServiceDiscovery(BuildContext context, SyncState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info on top of the button (remains visible even while scanning)
        if (state.discoveredServices.isEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The scan will test common network IPs and your local subnet to find Fasten servers automatically.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        // Centered rounded SCAN button with circular loading around while scanning
        if (state.discoveredServices.isEmpty)
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (state.isDiscovering)
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ElevatedButton(
                  onPressed: state.isDiscovering
                      ? null
                      : () {
                          if (state.discoveredServices.isNotEmpty) {
                            context.read<SyncBloc>().add(
                                  const SyncClearDiscoveredServices(),
                                );
                          }
                          context.read<SyncBloc>().add(
                                const SyncDiscoverServices(),
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(Insets.huge),
                  ),
                  child: const Text('SCAN', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        // Error is not shown here; it is displayed contextually under service tiles
        const SizedBox(height: 16),
        // Inline error below SCAN area (for scan/connect failures before any service is connected/listed)
        if (state.error != null && state.discoveredServices.isEmpty) ...[
          _buildErrorDisplay(context, state),
          const SizedBox(height: 16),
        ],

        // Discovery Status
        if (state.isDiscovering) ...[
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Scanning network…',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Services Found
        if (state.discoveredServices.isNotEmpty) ...[
          ...state.discoveredServices.map((service) {
            final isConnected =
                context.read<SyncBloc>().state.connectedService?.id ==
                    service.id;
            return Column(
              children: [
                _buildServiceTile(context, service),
                if (state.error != null && !isConnected) ...[
                  const SizedBox(height: 8),
                  _buildErrorDisplay(context, state),
                  const SizedBox(height: 8),
                  // Secondary SCAN action styled like Connect for retrying discovery quickly
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isDiscovering
                          ? null
                          : () {
                              context
                                  .read<SyncBloc>()
                                  .add(const SyncClearDiscoveredServices());
                              context
                                  .read<SyncBloc>()
                                  .add(const SyncDiscoverServices());
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('SCAN'),
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ],
    );
  }

  Widget _buildServiceTile(BuildContext context, SSDPServiceInfo service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.medical_services,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.friendlyName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${service.serverAddress}:${service.serverPort}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Service Details
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service Details',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow(context, 'ID', service.id),
              _buildDetailRow(context, 'Type', service.serviceType),
              _buildDetailRow(
                  context,
                  'Discovered',
                  service.discoveredAt != null
                      ? '${DateFormatUtils.humanReadable(service.discoveredAt!)} ${DateFormat('HH:mm').format(service.discoveredAt!)}'
                      : 'Unknown'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Action Button(s)
        Builder(builder: (context) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;
          final isDark = theme.brightness == Brightness.dark;
          final isConnected =
              context.read<SyncBloc>().state.connectedService?.id == service.id;
          final showSync = isConnected;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.read<SyncBloc>().add(showSync
                      ? const SyncData()
                      : SyncConnectToService(service)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showSync ? colorScheme.primary : colorScheme.secondary,
                    foregroundColor: isDark
                        ? Colors.white
                        : (showSync
                            ? colorScheme.onPrimary
                            : colorScheme.onSecondary),
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(showSync ? Icons.sync : Icons.link),
                      const SizedBox(width: 8),
                      Text(showSync ? 'SYNC' : 'Connect'),
                    ],
                  ),
                ),
              ),
              if (isConnected) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context
                        .read<SyncBloc>()
                        .add(const SyncDisconnectFromService()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor:
                          isDark ? Colors.white : colorScheme.onError,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Disconnect'),
                  ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }

  Widget _buildErrorDisplay(BuildContext context, SyncState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 36, 8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    state.error!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red.shade700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -0,
            right: -0,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () => context.read<SyncBloc>().add(
                      const SyncClearError(),
                    ),
                icon: const Icon(Icons.close, size: 18),
                color: Colors.red.shade700,
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                splashRadius: 16,
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
