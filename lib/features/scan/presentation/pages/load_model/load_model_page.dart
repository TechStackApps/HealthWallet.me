import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/presentation/pages/load_model/bloc/load_model_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/custom_progress_indicator.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/gen/assets.gen.dart';

@RoutePage<bool>()
class LoadModelPage extends StatefulWidget {
  const LoadModelPage({super.key});

  @override
  State<LoadModelPage> createState() => _LoadModelPageState();
}

class _LoadModelPageState extends State<LoadModelPage> {
  final _bloc = getIt.get<LoadModelBloc>();

  @override
  void initState() {
    super.initState();

    _bloc.add(const LoadModelInitialized());
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
              title: Text(
                context.l10n.aiModelTitle,
                style: AppTextStyle.titleMedium,
              ),
              automaticallyImplyLeading:
                  state.status != LoadModelStatus.loading,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildView(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildView(BuildContext context, LoadModelState state) {
    if (state.status == LoadModelStatus.loading &&
        state.downloadProgress == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Assets.images.placeholder.svg(height: 250),
        Text(
          context.l10n.aiModelUnlockTitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.titleLarge.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          context.l10n.aiModelUnlockDescription,
          textAlign: TextAlign.center,
          style: AppTextStyle.bodySmall.copyWith(
            color: context.colorScheme.onSurface.withOpacity(0.7),
            height: 1.5,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          context.l10n.aiModelDownloadInfo,
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
              onPressed: () =>
                  _bloc.add(const LoadModelDownloadInitiated()),
              child: Text(context.l10n.aiModelEnableDownload),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.router.maybePop(),
              child: Text(context.l10n.cancel),
            ),
          ),
        ] else
          CustomProgressIndicator(
            progress: state.downloadProgress! / 100,
            text: context.l10n.aiModelDownloading,
          ),
      ],
    );
  }
}
