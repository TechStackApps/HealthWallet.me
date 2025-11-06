import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/presentation/pages/load_model/bloc/load_model_bloc.dart';

class LoadModelEmbedded extends StatefulWidget {
  final VoidCallback? onModelReady;

  const LoadModelEmbedded({super.key, this.onModelReady});

  @override
  State<LoadModelEmbedded> createState() => _LoadModelEmbeddedState();
}

class _LoadModelEmbeddedState extends State<LoadModelEmbedded> {
  final _bloc = getIt.get<LoadModelBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(const LoadModelInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<LoadModelBloc, LoadModelState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == LoadModelStatus.modelLoaded) {
            widget.onModelReady?.call(); // trigger skip
          }
        },
        child: BlocBuilder<LoadModelBloc, LoadModelState>(
          builder: (context, state) {
            switch (state.status) {
              case LoadModelStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case LoadModelStatus.modelAbsent:
                return TextButton(
                    onPressed: () =>
                        _bloc.add(const LoadModelDownloadInitiated()),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(context.l10n.aiModelEnableDownload));
              case LoadModelStatus.error:
                return Text(
                  context.l10n.aiModelError,
                  textAlign: TextAlign.center,
                );
              case LoadModelStatus.modelLoaded:
                return Text(
                  context.l10n.aiModelReady,
                  textAlign: TextAlign.center,
                );
            }
          },
        ),
      ),
    );
  }
}
