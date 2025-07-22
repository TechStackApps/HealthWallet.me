part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial()) HomeStatus status,
    @Default([]) List<VitalSign> vitalSigns,
    @Default([]) List<OverviewCard> overviewCards,
    @Default([]) List<FhirResource> recentRecords,
    @Default([]) List<Source> sources,
    @Default(0) int selectedIndex,
    @Default('All') String selectedSource,
    @Default({
      ClinicalDataTags.allergy: true,
      ClinicalDataTags.medication: true,
      ClinicalDataTags.condition: true,
      ClinicalDataTags.immunization: true,
      ClinicalDataTags.labResult: true,
      ClinicalDataTags.procedure: true,
      ClinicalDataTags.goal: true,
      ClinicalDataTags.careTeam: true,
      ClinicalDataTags.clinicalNotes: true,
      ClinicalDataTags.files: true,
      ClinicalDataTags.facilities: true,
      ClinicalDataTags.demographics: true,
    })
    Map<String, bool> selectedResources,
    FhirResource? patient,
    String? errorMessage,
    @Default(false) bool editMode,
  }) = _HomeState;
}

@freezed
class HomeStatus with _$HomeStatus {
  const factory HomeStatus.initial() = _Initial;
  const factory HomeStatus.loading() = _Loading;
  const factory HomeStatus.success() = _Success;
  const factory HomeStatus.failure(Object error) = _Failure;
}
