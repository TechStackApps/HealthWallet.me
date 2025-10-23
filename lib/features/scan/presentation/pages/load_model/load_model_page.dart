import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/presentation/pages/load_model/bloc/load_model_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/gen/assets.gen.dart';

@RoutePage<bool>()
class LoadModelPage extends StatefulWidget {
  const LoadModelPage({super.key});

  @override
  State<LoadModelPage> createState() => _LoadModelPageState();
}

class _LoadModelPageState extends State<LoadModelPage>
    with TickerProviderStateMixin {
  late final AnimationController _shimmerController;

  final _bloc = getIt.get<LoadModelBloc>();

  @override
  void initState() {
    log(_bloc.toString());
    super.initState();

    _bloc.add(const LoadModelInitialized());

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<LoadModelBloc, LoadModelState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == LoadModelStatus.modelLoaded) {
              context.router.maybePop(true);
            }
            if (state.status == LoadModelStatus.error &&
                state.errorMessage != null) {
              DialogHelper.showErrorDialog(context, state.errorMessage!);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Load AI Model",
                    style: AppTextStyle.titleMedium),
                automaticallyImplyLeading:
                    state.status != LoadModelStatus.loading,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildView(state),
              ),
            );
          }),
    );
  }

  Widget _buildView(LoadModelState state) {
    if (state.status == LoadModelStatus.loading &&
        state.downloadProgress == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Assets.images.placeholder.svg(height: 250),
        Text(
          "Unlock AI-Powered Scanning",
          textAlign: TextAlign.center,
          style: AppTextStyle.titleLarge.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "To automatically read and organize your medical documents, this feature uses a secure, on-device AI model. This keeps your data completely private.",
          textAlign: TextAlign.center,
          style: AppTextStyle.bodySmall.copyWith(
            color: context.colorScheme.onSurface..withValues(alpha: 0.7),
            height: 1.5,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "To get started, we need to download the AI component (approx. 1.5 GB). This is a one-time setup.",
          textAlign: TextAlign.center,
          style: AppTextStyle.bodySmall.copyWith(
            color: context.colorScheme.onSurface..withValues(alpha: 0.7),
            height: 1.5,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 24),
        if (state.status != LoadModelStatus.loading) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.isDarkMode
                    ? Colors.white
                    : context.colorScheme.onPrimary,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8)),
              ),
              onPressed: () => _bloc.add(const LoadModelDownloadInitiated()),
              child: const Text("Enable & Download"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.router.maybePop(),
              child: const Text("Cancel"),
            ),
          ),
        ] else
          _buildLoadingWidget(state.downloadProgress!)
      ],
    );
  }

  Widget _buildLoadingWidget(double downloadProgress) {
    final baseColor = context.colorScheme.onSurface.withValues(alpha: 0.7);
    final highlightColor = context.colorScheme.onSurface.withValues(alpha: 0.3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        LinearProgressIndicator(
          value: downloadProgress / 100,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.1),
          color: context.colorScheme.primary,
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, _) {
            final slidePercent = _shimmerController.value;
            const slideDistance = 1.5;
            final gradientStart =
                -slideDistance + (slidePercent * 2 * slideDistance);
            final gradientEnd = gradientStart + slideDistance;

            return ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [baseColor, highlightColor, baseColor],
                stops: const [0.3, 0.5, 0.7],
                begin: Alignment(gradientStart, 0.0),
                end: Alignment(gradientEnd, 0.0),
              ).createShader(bounds),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Downloading secure AI Model",
                    style: AppTextStyle.bodySmall.copyWith(
                        color: context.colorScheme.onSurface
                            .withValues(alpha: 0.7)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
