part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial()) HomeStatus status,
    @Default([]) List<VitalSign> vitalSigns,
    @Default([]) List<OverviewCard> overviewCards,
    @Default([]) List<RecentRecord> recentRecords,
    @Default(0) int selectedIndex,
    @Default('All') String selectedSource,
    String? errorMessage,
  }) = _HomeState;
}

@freezed
class HomeStatus with _$HomeStatus {
  const factory HomeStatus.initial() = _Initial;
  const factory HomeStatus.loading() = _Loading;
  const factory HomeStatus.success() = _Success;
  const factory HomeStatus.failure(Object error) = _Failure;
}
