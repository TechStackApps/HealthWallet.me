// patient_source_info_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';

class PatientSourceInfoWidget extends StatelessWidget {
  final String? title;

  const PatientSourceInfoWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Insets.normal),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: context.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title ?? 'Patient & Source Information',
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.patient?.displayTitle ?? 'No patient selected',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getSourceDisplayName(state),
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getSourceDisplayName(HomeState state) {
    if (state.selectedSource == 'All') {
      return 'All sources';
    }

    // Find the source in the sources list
    final source = state.sources.firstWhere(
      (source) => source.id == state.selectedSource,
      orElse: () =>
          const Source(id: '', name: null, logo: null, labelSource: null),
    );

    // Return labelSource > name > id (same logic as SourceSelectorWidget)
    if (source.labelSource?.isNotEmpty == true) {
      return source.labelSource!;
    }
    if (source.name?.isNotEmpty == true) {
      return source.name!;
    }
    // If source ID is too long, don't display it
    if (source.id.length > 20) {
      return 'Unknown Source';
    }
    return source.id;
  }
}
