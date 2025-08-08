part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial()) HomeStatus status,
    @Default([]) List<VitalSign> vitalSigns,
    @Default([]) List<OverviewCard> overviewCards,
    @Default([]) List<IFhirResource> recentRecords,
    @Default([]) List<Source> sources,
    @Default(0) int selectedIndex,
    @Default('All') String selectedSource,
    @Default({
      HomeRecordsCategory.allergies: true,
      HomeRecordsCategory.medications: true,
      HomeRecordsCategory.healthIssues: true,
      HomeRecordsCategory.immunizations: true,
      HomeRecordsCategory.labResults: true,
      HomeRecordsCategory.procedures: true,
      HomeRecordsCategory.healthGoals: true,
      HomeRecordsCategory.careTeam: true,
      HomeRecordsCategory.clinicalNotes: true,
      HomeRecordsCategory.files: true,
      HomeRecordsCategory.facilities: true,
      HomeRecordsCategory.demographics: true,
      HomeRecordsCategory.healthInsurance: true,
    })
    Map<HomeRecordsCategory, bool> selectedRecordTypes,
    FhirResourceDto? patient,
    String? selectedPatientName,
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
