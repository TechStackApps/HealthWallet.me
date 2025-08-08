import 'dart:io';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/presentation/widgets/record_attachments/bloc/record_attachments_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class RecordAttachmentsWidget extends StatefulWidget {
  const RecordAttachmentsWidget({required this.resource, super.key});

  final IFhirResource resource;

  @override
  State<RecordAttachmentsWidget> createState() =>
      _RecordAttachmentsWidgetState();
}

class _RecordAttachmentsWidgetState extends State<RecordAttachmentsWidget> {
  final _bloc = getIt.get<RecordAttachmentsBloc>();

  @override
  void initState() {
    _bloc.add(RecordAttachmentsInitialised(resource: widget.resource));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<RecordAttachmentsBloc, RecordAttachmentsState>(
        builder: (context, state) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height/1.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.status == const RecordAttachmentsStatus.loading())
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color:
                                  AppColors.textPrimary.withValues(alpha: 0.1),
                              width: 1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Attachments",
                            style: AppTextStyle.bodyMedium),
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
                if (state.attachments.isEmpty)
                  const Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "This record has no files attached",
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
                        children: [
                          ...state.attachments.map(
                              (attachment) => _buildAttachmentRow(attachment))
                        ],
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
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result == null) return;

                      File selectedFile = File(result.files.first.path!);

                      _bloc.add(RecordAttachmentsFileAttached(selectedFile));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.attachment
                            .svg(width: 16, color: Colors.white),
                        const SizedBox(width: 4),
                        const Text("Attach file",
                            style: AppTextStyle.buttonMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAttachmentRow(RecordAttachment attachment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Assets.icons.documentFile.svg(width: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    basename(attachment.file.path),
                    style: AppTextStyle.labelLarge,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  onTap: () => SharePlus.instance
                      .share(ShareParams(files: [XFile(attachment.file.path)])),
                  child: Assets.icons.download.svg(width: 24),
                ),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                    onTap: () =>
                        _bloc.add(RecordAttachmentsFileDeleted(attachment)),
                    child: Assets.icons.trashCan.svg(width: 24)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
