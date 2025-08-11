import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';

@RoutePage()
class RecordDetailsPage extends StatelessWidget {
  final IFhirResource resource;

  const RecordDetailsPage({
    super.key,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<RecordsBloc>()..add(RecordDetailLoaded(resource)),
      child: BlocBuilder<RecordsBloc, RecordsState>(
        builder: (context, state) {
          IFhirResource? encounter = state.relatedResources.firstWhere(
            (resource) => resource.fhirType == FhirType.Encounter,
            orElse: () => const GeneralResource(),
          );

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Record Details',
                style: AppTextStyle.titleMedium,
              ),
              centerTitle: false,
              backgroundColor: context.colorScheme.surface,
              leading: IconButton(
                onPressed: () => context.router.maybePop(),
                icon: const Icon(Icons.arrow_back),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // TODO: Implement sharing functionality
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(Insets.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(context),
                  const SizedBox(height: 20),
                  if (resource.fhirType != FhirType.Encounter &&
                      encounter.fhirType == FhirType.Encounter)
                    _buildEncounterDetails(context, encounter as Encounter),
                  if (state.relatedResources.isNotEmpty)
                    _buildRelatedResourcesSection(
                        context, state.relatedResources),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.small,
              vertical: Insets.extraSmall,
            ),
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                resource.fhirType.icon.svg(width: 15),
                const SizedBox(width: 4),
                Text(
                  resource.fhirType.display,
                  style: AppTextStyle.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(resource.displayTitle, style: AppTextStyle.bodyMedium),
          ...resource.additionalInfo.map((infoLine) => Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      infoLine.icon
                          .svg(width: 16, color: AppColors.textPrimary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          infoLine.info,
                          style: AppTextStyle.labelLarge
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildEncounterDetails(BuildContext context, Encounter encounter) {
    return InkWell(
      onTap: () => context.router.push(RecordDetailsRoute(resource: encounter)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Encounter details", style: AppTextStyle.buttonSmall),
          const SizedBox(height: 4),
          _buildRelatedResourceInfo(encounter),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.textPrimary.withValues(alpha: 0.1)),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedResourcesSection(
      BuildContext context, List<IFhirResource> resources) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Related resources", style: AppTextStyle.buttonSmall),
        const SizedBox(height: 16),
        ...resources.map((resource) => InkWell(
              onTap: () =>
                  context.router.push(RecordDetailsRoute(resource: resource)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resource.displayTitle, style: AppTextStyle.labelLarge),
                  _buildRelatedResourceInfo(resource),
                  const SizedBox(height: 16),
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildRelatedResourceInfo(IFhirResource resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: resource.additionalInfo
          .take(2)
          .map(
            (infoLine) => Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    infoLine.icon.svg(
                        width: 16,
                        color: AppColors.textPrimary.withValues(alpha: 0.6)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        infoLine.info,
                        style: AppTextStyle.labelLarge.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.6)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
