import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';

@RoutePage()
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SyncBloc>(), // No automatic discovery
      child: const SyncView(),
    );
  }
}

class SyncView extends StatelessWidget {
  const SyncView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasten Sync'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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

                  // Connection Actions
                  if (state.discoveredServices.isNotEmpty)
                    _buildConnectionActions(context, state),

                  // Error Display
                  if (state.error != null) _buildErrorDisplay(context, state),

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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.85),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface,
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildStatusIndicator(state.syncStatus),
                const SizedBox(width: 8),
                Text(
                  _getStatusText(state.syncStatus),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            if (state.connectedService != null) ...[
              const SizedBox(height: 8),
              Text(
                'Connected to: ${state.connectedService!.friendlyName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ] else if (state.discoveredServices.isEmpty &&
                !state.isDiscovering) ...[
              const SizedBox(height: 8),
              Text(
                'Ready to scan for Fasten servers',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
            if (state.lastSyncTime != null) ...[
              const SizedBox(height: 8),
              Text(
                'Last sync: ${_formatDateTime(state.lastSyncTime!)}',
                style: Theme.of(context).textTheme.bodySmall,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info on top of the button
            if (state.discoveredServices.isEmpty && !state.isDiscovering) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
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
            // Centered rounded START SEARCH button
            Center(
              child: ElevatedButton(
                onPressed: state.isDiscovering
                    ? null
                    : () {
                        if (state.discoveredServices.isNotEmpty) {
                          context.read<SyncBloc>().add(
                                const SyncEvent.clearDiscoveredServices(),
                              );
                        }
                        context.read<SyncBloc>().add(
                              const SyncEvent.discoverServices(),
                            );
                      },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  minimumSize: const Size(240, 56),
                ),
                child:
                    Text(state.isDiscovering ? 'Scanning...' : 'START SEARCH'),
              ),
            ),
            const SizedBox(height: 16),

            // (info moved above the button)

            // Discovery Status
            if (state.isDiscovering) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scanning network for Fasten servers...',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Testing IP addresses in parallel for faster discovery',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Services Found
            if (state.discoveredServices.isNotEmpty) ...[
              ...state.discoveredServices
                  .map((service) => _buildServiceTile(context, service)),
            ],
          ],
        ),
      ),
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
                      ? _formatDateTime(service.discoveredAt!)
                      : 'Unknown'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => context.read<SyncBloc>().add(
                      SyncEvent.connectToService(service),
                    ),
                icon: const Icon(Icons.link),
                label: const Text('Connect'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => context.read<SyncBloc>().add(
                      SyncEvent.syncData(),
                    ),
                icon: const Icon(Icons.sync),
                label: const Text('SYNC'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConnectionActions(BuildContext context, SyncState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => context.read<SyncBloc>().add(
                              SyncEvent.testConnection(state.connectedService!),
                            ),
                    icon: const Icon(Icons.wifi),
                    label: const Text('Test Connection'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => context.read<SyncBloc>().add(
                              const SyncEvent.disconnectFromService(),
                            ),
                    icon: const Icon(Icons.link_off),
                    label: const Text('Disconnect'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Data Sync section removed per request

  Widget _buildErrorDisplay(BuildContext context, SyncState state) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Error',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.red,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.read<SyncBloc>().add(
                    const SyncEvent.clearError(),
                  ),
              child: const Text('Dismiss'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
