import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/data/mock_data.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/recent_record.dart';
import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecordsRepository _recordsRepository;

  HomeBloc(this._recordsRepository) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        initialised: () => _onInitialised(event, emit),
        sourceChanged: (source) => _onSourceChanged(source, emit),
      );
    });
  }

  Future<void> _onSourceChanged(String source, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedSource: source));
  }

  Future<void> _onInitialised(HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      // Simulate network delay for dashboard data
      // await Future.delayed(const Duration(seconds: 1));

      final allergies = await _recordsRepository.getAllergies();
      final medications = await _recordsRepository.getMedications();
      final conditions = await _recordsRepository.getConditions();
      final immunizations = await _recordsRepository.getImmunizations();
      final labResults = await _recordsRepository.getLabResults();
      final procedures = await _recordsRepository.getProcedures();

      final overviewCards = [
        OverviewCard(
          title: ClinicalDataTags.allergy,
          count: allergies.length.toString(),
          icon: Icons.warning_amber_outlined,
          iconColor: Colors.orange,
        ),
        OverviewCard(
          title: ClinicalDataTags.medication,
          count: medications.length.toString(),
          icon: Icons.medication_outlined,
          iconColor: AppColors.fastenLightPrimaryColor,
        ),
        OverviewCard(
          title: ClinicalDataTags.condition,
          count: conditions.length.toString(),
          icon: Icons.medical_services_outlined,
          iconColor: AppColors.fastenLightPrimaryColor,
        ),
        OverviewCard(
          title: ClinicalDataTags.immunization,
          count: immunizations.length.toString(),
          icon: Icons.vaccines_outlined,
          iconColor: AppColors.fastenLightPrimaryColor,
        ),
        OverviewCard(
          title: ClinicalDataTags.labResult,
          count: labResults.length.toString(),
          icon: Icons.science_outlined,
          iconColor: AppColors.fastenLightPrimaryColor,
        ),
        OverviewCard(
          title: ClinicalDataTags.procedure,
          count: procedures.length.toString(),
          icon: Icons.healing_outlined,
          iconColor: AppColors.fastenLightPrimaryColor,
        ),
      ];

      emit(
        state.copyWith(
          status: const HomeStatus.success(),
          vitalSigns: MockData.vitalSigns,
          overviewCards: overviewCards,
          recentRecords: MockData.recentRecords,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }
}
