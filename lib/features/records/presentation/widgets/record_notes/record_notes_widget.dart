import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/presentation/widgets/record_notes/bloc/record_notes_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/date_format_utils.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class RecordNotesWidget extends StatefulWidget {
  const RecordNotesWidget({required this.resource, super.key});

  final IFhirResource resource;

  @override
  State<RecordNotesWidget> createState() => _RecordNotesWidgetState();
}

class _RecordNotesWidgetState extends State<RecordNotesWidget> {
  final _bloc = getIt.get<RecordNotesBloc>();

  @override
  void initState() {
    _bloc.add(RecordNotesInitialised(resource: widget.resource));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<RecordNotesBloc, RecordNotesState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.status == const RecordNotesStatus.loading())
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (state.status == const RecordNotesStatus.input())
                _buildInputWidget(state)
              else
                _buildMainWidget(state)
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainWidget(RecordNotesState state) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: context.theme.dividerColor, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notes", style: AppTextStyle.bodyMedium),
                IconButton(
                  iconSize: 20,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          if (state.notes.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "This record has no notes attached",
                  style: AppTextStyle.labelLarge,
                ),
              ),
            )
          else
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ListView(
                  shrinkWrap: true,
                  children: state.notes
                      .map((note) => _buildNoteWidget(
                            note: note,
                            isLast: note == state.notes.last,
                          ))
                      .toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(6)),
              ),
              onPressed: () => _bloc.add(const RecordNotesInputInitialised()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.addPlus.svg(width: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  const Text("Add note", style: AppTextStyle.buttonSmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputWidget(RecordNotesState state) {
    final TextEditingController textController = TextEditingController();
    textController.text = state.editNote?.content ?? '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: context.theme.dividerColor, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        _bloc.add(const RecordNotesInputCanceled()),
                    icon: const Icon(Icons.arrow_back, size: 20),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  const SizedBox(width: 12),
                  Text(state.editNote != null ? "Edit note" : "Add note",
                      style: AppTextStyle.bodyMedium),
                ],
              ),
              IconButton(
                iconSize: 20,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            maxLines: 9,
            style: AppTextStyle.labelLarge,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(8),
            ),
            controller: textController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _bloc.add(const RecordNotesInputCanceled()),
                  child: Text(
                    "Cancel",
                    style: AppTextStyle.buttonSmall
                        .copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(6)),
                  ),
                  onPressed: () => textController.text != ''
                      ? _bloc.add(
                          RecordNotesInputDone(content: textController.text))
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.checkmarkCircleOutline
                          .svg(width: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      const Text("Done", style: AppTextStyle.buttonSmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoteWidget({
    required RecordNote note,
    required bool isLast,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormatUtils.humanReadable(note.timestamp),
              style: AppTextStyle.labelMedium.copyWith(
                  color: context.textTheme.bodyMedium?.color
                          ?.withValues(alpha: 0.6) ??
                      context.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.all(6),
                  child: GestureDetector(
                    onTap: () =>
                        _bloc.add(RecordNotesInputInitialised(editNote: note)),
                    child: Assets.icons.edit.svg(
                        width: 20,
                        color: context.theme.iconTheme.color ??
                            context.colorScheme.onSurface),
                  ),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsetsGeometry.all(6),
                  child: GestureDetector(
                    onTap: () => _showDeleteConfirmationDialog(context, note),
                    child: Assets.icons.trashCan.svg(
                        width: 20,
                        color: context.theme.iconTheme.color ??
                            context.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(note.content, style: AppTextStyle.labelLarge),
        const SizedBox(height: 16),
        if (!isLast)
          Divider(
            color: context.theme.dividerColor,
          )
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, RecordNote note) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final borderColor =
        context.isDarkMode ? AppColors.borderDark : AppColors.border;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(Insets.normal),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Insets.normal),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Content
                    Text(
                      'Are you sure you want to delete this note?',
                      style: AppTextStyle.labelLarge.copyWith(color: textColor),
                    ),

                    const SizedBox(height: Insets.small),

                    Container(
                      padding: const EdgeInsets.all(Insets.small),
                      decoration: BoxDecoration(
                        color: (context.colorScheme.error ?? Colors.red)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (context.colorScheme.error ?? Colors.red)
                              .withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: context.colorScheme.error ?? Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: Insets.small),
                          Expanded(
                            child: Text(
                              context.l10n.actionCannotBeUndone,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: context.colorScheme.error ?? Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: Insets.normal),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide.none,
                              padding: const EdgeInsets.all(8),
                              fixedSize: const Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: AppTextStyle.buttonSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _bloc.add(RecordNotesNoteDeleted(note: note));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  context.colorScheme.error ?? Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(8),
                              fixedSize: const Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Delete',
                              style: AppTextStyle.buttonSmall
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
