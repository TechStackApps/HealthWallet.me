part of 'timeline_bloc.dart';

enum TimelineStatus { initial, loading, success, failure }

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState({
    @Default(TimelineStatus.initial) TimelineStatus status,
    @Default([]) List<TimelineResourceModel> resources,
    @Default(true) bool hasMorePages,
    @Default(0) int page,
    @Default('') String error,
    @Default({}) Set<String> filters,
    String? sourceId,
  }) = _TimelineState;
}
