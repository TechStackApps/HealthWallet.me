import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/l10n/l10n.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/presentation/pages/load_model/bloc/load_model_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/core/widgets/custom_app_bar.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/documents_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_placeholder.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/scan/presentation/helpers/document_handler.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/page_view_navigation_controller.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/navigation_settled_callback_mixin.dart';

@RoutePage()
class ScanPage extends StatelessWidget {
  final PageViewNavigationController? navigationController;

  const ScanPage({super.key, this.navigationController});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance.get<ScanBloc>()),
        BlocProvider(
            create: (_) => GetIt.instance.get<LoadModelBloc>()
              ..add(const LoadModelInitialized())),
      ],
      child: ScanView(navigationController: navigationController),
    );
  }
}

class ScanView extends StatefulWidget {
  final PageViewNavigationController? navigationController;

  const ScanView({super.key, this.navigationController});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView>
    with DocumentHandler, NavigationSettledCallbackMixin {
  bool _hasAutoScanned = false;

  @override
  PageViewNavigationController? get navigationController =>
      widget.navigationController;

  @override
  void onPageSettled() {
    _autoStartScanning();
  }

  @override
  void onPageLeft() {
    setState(() {
      _hasAutoScanned = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeNavigationSettledListener(2);
  }

  @override
  void dispose() {
    disposeNavigationSettledListener();
    super.dispose();
  }

  Future<void> _autoStartScanning() async {
    if (_hasAutoScanned) {
      return;
    }

    _hasAutoScanned = true;

    final currentState = context.read<ScanBloc>().state;
    final hasAnyFiles = currentState.scannedImagePaths.isNotEmpty;

    if (!hasAnyFiles) {
      await _handleScanButtonPressed(context);
    }
  }

  void _resetAutoScanFlag() {
    if (_hasAutoScanned) {
      setState(() {
        _hasAutoScanned = false;
      });
      resetTriggerFlag();
    }
  }

  Future<void> _handleScanButtonPressed(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context.read<ScanBloc>().add(const ScanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      DialogHelper.showPermissionDeniedDialog(context);
    } else {
      DialogHelper.showPermissionRequiredDialog(
        context,
        () => _handleScanButtonPressed(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizationsX(context).l10n.onboardingScanButton),
        actions: [
          BlocBuilder<LoadModelBloc, LoadModelState>(
            builder: (context, state) {
              // Hide the button entirely if model is loaded
              if (state.status == LoadModelStatus.modelLoaded) {
                return const SizedBox.shrink();
              }

              return TextButton.icon(
                onPressed: () => context.router.push(const LoadModelRoute()),
                icon: const Icon(Icons.memory_outlined),
                label: Text(
                  AppLocalizationsX(context).l10n.onboardingAiModelTitle,
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: context.colorScheme.primary,
                ),
              );
            },
          ),
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state.scannedImagePaths.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () {
                  context.read<ScanBloc>().add(const ClearScans());
                },
                child: const Text('Clear'),
              );
            },
          ),
        ],
      ),
      body: BlocListener<ScanBloc, ScanState>(
        listenWhen: (previous, current) {
          return previous.scannedImagePaths.isNotEmpty &&
              current.scannedImagePaths.isEmpty;
        },
        listener: (context, state) {
          if (state.scannedImagePaths.isEmpty && _hasAutoScanned) {
            _resetAutoScanFlag();

            if (widget.navigationController?.currentPage == 2) {
              _autoStartScanning();
            }
          }
        },
        child: BlocBuilder<ScanBloc, ScanState>(
          builder: (context, state) {
            return state.status.when(
              initial: () => _buildMainView(context, state),
              loading: () => _buildLoadingView(),
              success: () => _buildMainView(context, state),
              failure: (error) => _buildMainView(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Opening scanner...'),
        ],
      ),
    );
  }

  Widget _buildMainView(BuildContext context, ScanState state) {
    final hasScans = state.scannedImagePaths.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: hasScans
                ? DocumentsGrid(
                    onAddScan: () => _handleDirectScan(context),
                    onScanTap: (filePath, index) =>
                        handleDocumentTap(context, filePath, index),
                    onDeleteScan: (filePath, index) =>
                        showDeleteConfirmation(context, filePath, index),
                    includeScannedImages: true,
                    includeImportedImages: false,
                    includeFiles: false,
                  )
                : ScanPlaceholder(
                    onScan: () => _handleDirectScan(context),
                  ),
          ),
          if (hasScans)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ActionButtons(
                onProcessToFhir: () => navigateToFhirMapper(
                  context,
                  state.scannedImagePaths,
                  const <String>[],
                  const <String>[],
                ),
                onAttachToEncounter: () => showEncounterSelector(
                  context,
                  state.scannedImagePaths,
                  const <String>[],
                  const <String>[],
                ),
                onExtractText: null,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handleDirectScan(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context.read<ScanBloc>().add(const ScanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      DialogHelper.showPermissionDeniedDialog(context);
    } else {
      DialogHelper.showPermissionRequiredDialog(
        context,
        () => _handleDirectScan(context),
      );
    }
  }
}
