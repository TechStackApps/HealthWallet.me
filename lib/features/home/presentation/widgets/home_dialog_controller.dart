import 'package:flutter/material.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/home/presentation/widgets/filter_home_dialog.dart';

class HomeDialogController {
  static void showEditRecordsDialog(
    BuildContext context,
    HomeState state,
    Function(Map<HomeRecordsCategory, bool>) onRecordsSaved,
  ) {
    showDialog(
      context: context,
      builder: (context) => FilterHomeDialog(
        type: FilterHomeType.records,
        selectedRecords: state.selectedRecordTypes,
        orderedRecords:
            state.overviewCards.map((c) => c.category).toList(growable: false),
        onRecordsSaved: onRecordsSaved,
      ),
    );
  }

  static void showEditVitalsDialog(
    BuildContext context,
    HomeState state,
    Function(Map<PatientVitalType, bool>) onVitalsSaved,
  ) {
    final displayedOrder = state.patientVitals
        .map((v) => PatientVitalTypeX.fromTitle(v.title))
        .whereType<PatientVitalType>()
        .toList(growable: false);
    final remaining = state.selectedVitals.keys
        .where((k) => !displayedOrder.contains(k))
        .toList(growable: false);
    final orderedVitals = [...displayedOrder, ...remaining];

    showDialog(
      context: context,
      builder: (context) => FilterHomeDialog(
        type: FilterHomeType.vitals,
        selectedVitals: state.selectedVitals,
        orderedVitals: orderedVitals,
        onVitalsSaved: onVitalsSaved,
      ),
    );
  }
}
