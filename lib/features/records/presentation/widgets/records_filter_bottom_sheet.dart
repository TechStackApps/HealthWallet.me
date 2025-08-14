import 'package:flutter/material.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class RecordsFilterBottomSheet extends StatefulWidget {
  const RecordsFilterBottomSheet({
    required this.activeFilters,
    required this.onApply,
    super.key,
  });

  final List<FhirType> activeFilters;
  final Function(List<FhirType>) onApply;

  @override
  State<RecordsFilterBottomSheet> createState() =>
      _RecordsFilterBottomSheetState();
}

class _RecordsFilterBottomSheetState extends State<RecordsFilterBottomSheet> {
  List<FhirType> _selectedFilters = [];

  @override
  void initState() {
    _selectedFilters = [...widget.activeFilters];
    super.initState();
  }

  void _toggleFitler(FhirType filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.12,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.colorScheme.onSurface.withOpacity(0.18),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filters",
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    iconSize: 18,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      "Record type",
                      style: AppTextStyle.buttonSmall.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: FhirType.values.map((filter) {
                        final isSelected = _selectedFilters.contains(filter);
                        return GestureDetector(
                          onTap: () => _toggleFitler(filter),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.colorScheme.primary
                                      .withOpacity(0.12)
                                  : context.colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(filter.display,
                                style: AppTextStyle.labelLarge.copyWith(
                                  color: isSelected
                                      ? context.colorScheme.primary
                                      : context.colorScheme.onSurface,
                                )),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.colorScheme.onSurface.withOpacity(0.18),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: AppTextStyle.buttonMedium.copyWith(
                          color: context.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.isDarkMode
                            ? Colors.white
                            : context.colorScheme.onPrimary,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(6)),
                      ),
                      onPressed: () {
                        widget.onApply.call(_selectedFilters);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.checkmarkCircleOutline
                              .svg(width: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          const Text("Apply filters",
                              style: AppTextStyle.buttonMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
