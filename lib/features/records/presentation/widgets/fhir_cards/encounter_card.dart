import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/pages/record_detail_page.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/widgets/record_attachments/record_attachments_widget.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:get_it/get_it.dart';

class EncounterCard extends StatefulWidget {
  final IFhirResource encounter;

  const EncounterCard({super.key, required this.encounter});

  @override
  State<EncounterCard> createState() => _EncounterCardState();
}

class _EncounterCardState extends State<EncounterCard> {
  bool _isExpanded = false;
  final Map<String, String> _resolvedNames = {};
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    if (_isExpanded) {
      _hideRelated();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main encounter info (always visible)
          _buildMainEncounterInfo(context),

          // Expand/Collapse button (always visible, positioned at top)
          const SizedBox(height: Insets.small),
          _buildExpandButton(context),

          // // Expandable section for related resources (below the button)
          // if (_isExpanded) ...[
          //   const SizedBox(height: Insets.small),
          //   _buildRelatedResourcesSection(context),
          // ],
        ],
      ),
    );
  }

  Widget _buildMainEncounterInfo(BuildContext context) {
    final encounter = widget.encounter as Encounter;
    String? participant =
        encounter.participant?[0].individual?.display?.valueString;
    String? serviceProvider = encounter.serviceProvider?.display?.valueString;

    return InkWell(
      onTap: () {
        // Navigate to encounter detail page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecordDetailPage(resource: widget.encounter),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encounter type and status
          Text(
            encounter.title,
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Practitioner info
          if (encounter.participant?.isNotEmpty == true) ...[
            Row(
              children: [
                Assets.icons.user.svg(width: 16),
                const SizedBox(width: Insets.smaller),
                Expanded(
                  child: Text(
                    participant ?? 'Participant',
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Organization info
          if (encounter.serviceProvider != null) ...[
            Row(
              children: [
                Assets.icons.hospital.svg(width: 16),
                const SizedBox(width: Insets.smaller),
                Expanded(
                  child: Text(
                    serviceProvider ?? 'Service provider',
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _toggleRelated() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _showRelated();
      context
          .read<RecordsBloc>()
          .add(RecordDetailLoaded(widget.encounter.resourceId));
    } else {
      _hideRelated();
    }
  }

  void _hideRelated() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showRelated() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width + 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(-16, size.height + 8),
          child: Material(
            child: _buildRelatedResourcesSection(context),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  Widget _buildExpandButton(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, state) {
        final isLoadingRelated =
            state.recordDetailStatus == RecordDetailStatus.loading();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Right side: Text and loading indicator (with InkWell only here)
            InkWell(
              onTap: _toggleRelated,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    if (isLoadingRelated)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Text(
                        _isExpanded ? 'Hide Related' : 'View Related',
                        style: AppTextStyle.bodySmall,
                      ),
                    if (!isLoadingRelated) ...[
                      const SizedBox(width: Insets.extraSmall),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.chevron_right,
                        size: 16,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // TODO: Implement license draft notes functionality
                    print('License draft notes tapped');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.licenseDraftNotes.svg(
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: Insets.normal),
                InkWell(
                  onTap: () => showRecordActionDialog(
                      RecordAttachmentsWidget(resource: widget.encounter)),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.attachment.svg(width: 24),
                  ),
                ),
                const SizedBox(width: Insets.normal),
                InkWell(
                  onTap: () {
                    // TODO: Implement share functionality
                    print('Share tapped');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.share.svg(width: 24),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildRelatedResourcesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(
            color: AppColors.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: AppColors.textPrimary.withValues(alpha: 0.3),
              blurRadius: 5,
            ),
          ]),
      height: MediaQuery.sizeOf(context).height / 2.5,
      child: BlocBuilder<RecordsBloc, RecordsState>(
        builder: (context, state) {
          if (state.recordDetailStatus == RecordDetailStatus.loading()) {
            return const Padding(
              padding: EdgeInsets.all(Insets.normal),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: Insets.small),
                    Text('Loading related resources...'),
                  ],
                ),
              ),
            );
          }

          if (state.relatedResources.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 32,
                      color: context.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      'No related resources found for this encounter',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.relatedResources
                  .map(
                    (resource) => Padding(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                      child: Text(
                        "${resource.fhirType.display}: ${resource.title}",
                        style: AppTextStyle.bodySmall,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  void showRecordActionDialog(Widget child) => showDialog(
        context: context,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          ),
        ),
      );

  // // Helper methods for extracting FHIR R4 data
  // String _getEncounterTitle(Encounter encounter) {
  //   // Use the title field directly if available
  //   if (encounter.title.isNotEmpty) {
  //     return encounter.title;
  //   }

  //   // Fallback to encounter type or status
  //   if (encounter.type?.isNotEmpty == true) {
  //     final firstType = encounter.type!.first;
  //     return firstType.text?.valueString ??
  //         firstType.coding?.firstOrNull?.display?.valueString ??
  //         'Encounter';
  //   }

  //   return 'Encounter';
  // }

  // String _getParticipantNames(Encounter encounter) {
  //   if (encounter.participant?.isEmpty ?? true) {
  //     return 'No participants';
  //   }

  //   // Get the first participant's name (most common case)
  //   final firstParticipant = encounter.participant!.first;
  //   if (firstParticipant.individual?.reference?.valueString != null) {
  //     final reference = firstParticipant.individual!.reference!.valueString!;
  //     log("A");
  //     // Check if we already resolved this reference
  //     if (_resolvedNames.containsKey(reference)) {
  //       log("B");
  //       return _resolvedNames[reference]!;
  //     } else {
  //       // Resolve the reference asynchronously
  //       _resolveReference(reference);
  //       log("C");
  //       // Show fallback while resolving
  //       if (reference.contains('/')) {
  //         log("D");
  //         final parts = reference.split('/');
  //         return parts.length >= 2 ? parts[parts.length - 2] : 'Participant';
  //       }
  //       return 'Practitioner';
  //     }
  //   }

  //   return 'No participants';
  // }

  // String _getServiceProviderName(Encounter encounter) {
  //   if (encounter.serviceProvider?.reference?.valueString != null) {
  //     final reference = encounter.serviceProvider!.reference!.valueString!;

  //     // Check if we already resolved this reference
  //     if (_resolvedNames.containsKey(reference)) {
  //       return _resolvedNames[reference]!;
  //     } else {
  //       // Resolve the reference asynchronously
  //       _resolveReference(reference);

  //       // Show fallback while resolving
  //       if (reference.contains('/')) {
  //         final parts = reference.split('/');
  //         return parts.length >= 2 ? parts[parts.length - 2] : 'Organization';
  //       }
  //       return 'Organization';
  //     }
  //   }
  //   return 'No organization';
  // }

  // Future<void> _resolveReference(String reference) async {
  //   try {
  //     // Get the repository through dependency injection
  //     final repository = GetIt.instance<RecordsRepository>();
  //     final displayName = await repository.getReferenceDisplayName(reference);

  //     if (displayName != null && mounted) {
  //       setState(() {
  //         _resolvedNames[reference] = displayName;
  //       });
  //     }
  //   } catch (e) {
  //     // Handle error silently
  //   }
  // }
}
