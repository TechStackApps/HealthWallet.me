import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_resource_viewer.dart';

@RoutePage()
class RecordDetailPage extends StatelessWidget {
  final FhirResource resource;

  const RecordDetailPage({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.resourceType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.l10n.detailsFor}${resource.id}',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: Insets.normal),
              FhirResourceViewer(resource: resource),
            ],
          ),
        ),
      ),
    );
  }
}
