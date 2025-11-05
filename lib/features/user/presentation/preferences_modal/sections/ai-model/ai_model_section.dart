import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/presentation/pages/load_model/bloc/load_model_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/custom_progress_indicator.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class AiModelSection extends StatelessWidget {
  const AiModelSection({super.key});

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;

    return BlocProvider(
      create: (_) => getIt<LoadModelBloc>()..add(const LoadModelInitialized()),
      child: BlocConsumer<LoadModelBloc, LoadModelState>(
        listener: (context, state) {
          if (state.status == LoadModelStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.onboardingAiModelTitle, style: AppTextStyle.bodySmall),
                const SizedBox(height: Insets.small),
                Container(
                  padding: const EdgeInsets.all(Insets.smallNormal),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.small,
                              vertical: Insets.extraSmall,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.icons.download.svg(
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: Insets.extraSmall),
                                Text(
                                  _getModelStatusText(context, state.status),
                                  style: AppTextStyle.labelSmall.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Insets.normal),
                      Assets.images.placeholder.svg(
                        width: 140,
                        height: 140,
                      ),
                      const SizedBox(height: Insets.small),
                      Text(
                        context.l10n.onboardingAiModelDescription,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.labelLarge,
                      ),
                      const SizedBox(height: Insets.normal),
                      if (state.status == LoadModelStatus.modelAbsent)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => context
                                .read<LoadModelBloc>()
                                .add(const LoadModelDownloadInitiated()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              context.l10n.aiModelEnableDownload,
                              style: AppTextStyle.buttonSmall,
                            ),
                          ),
                        )
                      else if (state.status == LoadModelStatus.loading)
                        CustomProgressIndicator(
                          progress: (state.downloadProgress ?? 0) / 100,
                          text: context.l10n.aiModelDownloading,
                        )
                      else if (state.status == LoadModelStatus.modelLoaded)
                        Text(
                          context.l10n.aiModelReady,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getModelStatusText(BuildContext context, LoadModelStatus status) {
    switch (status) {
      case LoadModelStatus.modelLoaded:
        return context.l10n.aiModelReady;
      case LoadModelStatus.modelAbsent:
        return context.l10n.aiModelMissing;
      case LoadModelStatus.loading:
        return context.l10n.aiModelDownloading;
      case LoadModelStatus.error:
        return context.l10n.aiModelError;
    }
  }
}
