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
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FhirRepository _fhirRepository;
  final GetSourcesUseCase _getSourcesUseCase;

  HomeBloc(this._fhirRepository, this._getSourcesUseCase)
      : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        initialised: () => _onInitialised(event, emit),
        sourceChanged: (source) => _onSourceChanged(source, emit),
      );
    });
  }

  Future<void> _onSourceChanged(String source, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      selectedSource: source,
      status: const HomeStatus.loading(),
    ));
    try {
      final sourceId = source == 'All' ? null : source;

      final allergies = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.allergy],
        sourceId: sourceId,
      );
      final medications = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.medication],
        sourceId: sourceId,
      );
      final conditions = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.condition],
        sourceId: sourceId,
      );
      final immunizations = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.immunization],
        sourceId: sourceId,
      );
      final labResults = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.labResult],
        sourceId: sourceId,
      );
      final procedures = await _fhirRepository.getResources(
        resourceType:
            ClinicalDataTags.resourceTypeMap[ClinicalDataTags.procedure],
        sourceId: sourceId,
      );

      final overviewCards = [
        OverviewCard(
          title: ClinicalDataTags.allergy,
          count: allergies.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.medication,
          count: medications.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.condition,
          count: conditions.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.immunization,
          count: immunizations.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.labResult,
          count: labResults.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.procedure,
          count: procedures.length.toString(),
        ),
      ];

      final allResources =
          await _fhirRepository.getResources(sourceId: sourceId);

      allResources.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      allResources.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      emit(
        state.copyWith(
          status: const HomeStatus.success(),
          overviewCards: overviewCards,
          selectedSource: source,
          sources: state.sources,
          recentRecords: allResources.take(3).toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }

  Future<void> _onInitialised(HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      // Simulate network delay for dashboard data
      // await Future.delayed(const Duration(seconds: 1));

      final sources = await _getSourcesUseCase();
      sources.insert(0, const Source(id: 'All', name: 'All'));
      final allergies = await _fhirRepository.getResources(
          resourceType: 'AllergyIntolerance');
      final medications =
          await _fhirRepository.getResources(resourceType: 'MedicationRequest');
      final conditions =
          await _fhirRepository.getResources(resourceType: 'Condition');
      final immunizations =
          await _fhirRepository.getResources(resourceType: 'Immunization');
      final labResults =
          await _fhirRepository.getResources(resourceType: 'Observation');
      final procedures =
          await _fhirRepository.getResources(resourceType: 'Procedure');

      final overviewCards = [
        OverviewCard(
          title: ClinicalDataTags.allergy,
          count: allergies.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.medication,
          count: medications.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.condition,
          count: conditions.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.immunization,
          count: immunizations.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.labResult,
          count: labResults.length.toString(),
        ),
        OverviewCard(
          title: ClinicalDataTags.procedure,
          count: procedures.length.toString(),
        ),
      ];

      final allResources = await _fhirRepository.getResources();

      final recentRecords = allResources.map((e) {
        final resourceJson = e.resourceJson;
        final title = resourceJson['code']?['text'] ??
            resourceJson['vaccineCode']?['text'] ??
            e.resourceType;
        final doctor = resourceJson['recorder']?['display'] ?? 'N/A';
        final date = e.updatedAt.toString();
        return RecentRecord(
          title: title,
          doctor: doctor,
          date: date,
          tag: e.resourceType,
          tagBackgroundColor: Colors.blue.withOpacity(0.1),
          tagTextColor: Colors.blue,
        );
      }).toList();

      recentRecords.sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(
          status: const HomeStatus.success(),
          vitalSigns: MockData.vitalSigns,
          overviewCards: overviewCards,
          recentRecords: allResources.take(3).toList(),
          sources: sources,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }
}
