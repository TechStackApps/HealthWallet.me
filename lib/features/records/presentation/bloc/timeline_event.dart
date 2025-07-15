part of 'timeline_bloc.dart';

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent.load() = _Load;
  const factory TimelineEvent.loadMore() = _LoadMore;
  const factory TimelineEvent.filterChanged(Set<String> newFilters) =
      _FilterChanged;
  const factory TimelineEvent.sourceChanged(String? sourceId) = _SourceChanged;
}
