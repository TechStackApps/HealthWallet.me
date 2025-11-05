import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/helpers/document_handler.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/page_view_navigation_controller.dart';

class ImportPage extends StatelessWidget {
  final PageViewNavigationController? navigationController;

  const ImportPage({super.key, this.navigationController});

  @override
  Widget build(BuildContext context) {
    return ImportView(navigationController: navigationController);
  }
}

class ImportView extends StatefulWidget {
  final PageViewNavigationController? navigationController;

  const ImportView({super.key, this.navigationController});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> with DocumentHandler {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Import'),
        actions: [
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              final hasImportedImages = state.importedImagePaths.isNotEmpty;
              final hasPdfs = state.savedPdfPaths.isNotEmpty;
              if (!hasImportedImages && !hasPdfs)
                return const SizedBox.shrink();

              return TextButton(
                onPressed: () {
                  context.read<ScanBloc>().add(const ClearImports());
                },
                child: const Text('Clear'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ScanBloc, ScanState>(
        builder: (context, state) {
          final hasDocuments = state.importedImagePaths.isNotEmpty ||
              state.savedPdfPaths.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (!hasDocuments) ...[
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Icon(
                          Icons.cloud_download_outlined,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No documents yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Import or scan documents to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 40),
                        ScanActionButtons(
                          style: ScanActionButtonStyle.placeholder,
                          onScanDocument: () {
                            _navigateToScanTab(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: ScanGrid(
                      onAddScan: () => _showAddScanBottomSheet(context),
                      onScanTap: (filePath, index) =>
                          handleDocumentTap(context, filePath, index),
                      onDeleteScan: (filePath, index) =>
                          showDeleteConfirmation(context, filePath, index),
                      includeScannedImages: false,
                      includeImportedImages: true,
                      includeFiles: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActionButtons(
                      onProcessToFhir: () => navigateToFhirMapper(
                        context,
                        const <String>[],
                        state.importedImagePaths,
                        state.savedPdfPaths,
                      ),
                      onAttachToEncounter: () => showEncounterSelector(
                        context,
                        const <String>[],
                        state.importedImagePaths,
                        state.savedPdfPaths,
                      ),
                      onExtractText: null,
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToScanTab(BuildContext context) {
    widget.navigationController?.navigateToPage(2);
  }

  void _showAddScanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<ScanBloc>(),
        child: const ImportOptionsBottomSheet(),
      ),
    );
  }
}
