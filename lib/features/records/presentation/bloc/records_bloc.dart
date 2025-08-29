import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'records_event.dart';
part 'records_state.dart';
part 'records_bloc.freezed.dart';

@injectable
class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final RecordsRepository _recordsRepository;
  Timer? _searchDebounceTimer;
  bool _isSearching = false;

  RecordsBloc(this._recordsRepository) : super(const RecordsState()) {
    on<RecordsInitialised>(_onInitialised);
    on<RecordsLoadMore>(_onLoadMore);
    on<RecordsSourceChanged>(_onSourceChanged);
    on<RecordsFiltersApplied>(_onFiltersApplied);
    on<RecordsFilterRemoved>(_onFilterRemoved);
    on<RecordDetailLoaded>(_onRecordDetailLoaded);
    on<LoadDemoData>(_onLoadDemoData);
    on<ClearDemoData>(_onClearDemoData);
    on<RecordsSearch>(_onSearch);
    on<RecordsSearchExecuted>(_onSearchExecuted);
    on<RecordsSharePressed>(_onRecordsSharePressed);
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }

  Future _loadResources(
    Emitter<RecordsState> emit, {
    int limit = 20,
    offset = 0,
  }) async {
    final isSearching =
        state.searchQuery.isNotEmpty && state.searchQuery.length >= 2;
    if (isSearching && _isSearching) {
      return;
    }

    if (isSearching) {
      _isSearching = true;
    }

    emit(state.copyWith(status: const RecordsStatus.loading()));
    try {
      List<IFhirResource> resources;

      if (isSearching) {
        resources = await _recordsRepository.searchResources(
          query: state.searchQuery,
          resourceTypes: [],
          sourceId: state.sourceId,
          limit: 100,
        );
      } else {
        resources = await _recordsRepository.getResources(
          resourceTypes: state.activeFilters,
          sourceId: state.sourceId,
          limit: limit,
          offset: offset,
        );
      }

      final List<IFhirResource> updatedResources;
      if (offset == 0) {
        updatedResources = List<IFhirResource>.from(resources);
      } else {
        updatedResources = List<IFhirResource>.from(state.resources);
        updatedResources.addAll(resources);
      }

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: updatedResources,
          hasMorePages: isSearching ? false : resources.length == limit,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    } finally {
      if (state.searchQuery.isNotEmpty && state.searchQuery.length >= 2) {
        _isSearching = false;
      }
    }
  }

  Future<void> _onInitialised(
    RecordsInitialised event,
    Emitter<RecordsState> emit,
  ) async {
    if (state.activeFilters.isEmpty) {
      emit(state.copyWith(activeFilters: [FhirType.Encounter]));
    }

    await _loadResources(emit);
  }

  Future<void> _onLoadMore(
    RecordsLoadMore event,
    Emitter<RecordsState> emit,
  ) async {
    if (state.searchQuery.isNotEmpty && state.searchQuery.length >= 2) {
      return;
    }

    if (!state.hasMorePages) return;

    await _loadResources(emit, offset: state.resources.length);
  }

  Future<void> _onSourceChanged(
    RecordsSourceChanged event,
    Emitter<RecordsState> emit,
  ) async {
    var nextState = state.copyWith(
      sourceId: event.sourceId,
      resources: [],
      hasMorePages: true,
    );

    if (nextState.activeFilters.isEmpty) {
      nextState = nextState.copyWith(activeFilters: [FhirType.Encounter]);
    }

    emit(nextState);

    await _loadResources(emit);
  }

  void _onFiltersApplied(
    RecordsFiltersApplied event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      activeFilters: event.filters,
      resources: [],
    ));

    await _loadResources(emit);
  }

  void _onFilterRemoved(
    RecordsFilterRemoved event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      activeFilters: [...state.activeFilters]..remove(event.filter),
      resources: [],
    ));

    await _loadResources(emit);
  }

  Future<void> _onRecordDetailLoaded(
    RecordDetailLoaded event,
    Emitter<RecordsState> emit,
  ) async {
    emit(
        state.copyWith(recordDetailStatus: const RecordDetailStatus.loading()));
    try {
      final relatedResources = event.resource.fhirType == FhirType.Encounter
          ? await _recordsRepository.getRelatedResourcesForEncounter(
              encounterId: event.resource.resourceId,
              sourceId: event.resource.sourceId)
          : await _recordsRepository.getRelatedResources(
              resource: event.resource);

      emit(
        state.copyWith(
          recordDetailStatus: const RecordDetailStatus.success(),
          relatedResources: relatedResources,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        recordDetailStatus: RecordDetailStatus.failure(e),
      ));
    }
  }

  Future<void> _onLoadDemoData(
    LoadDemoData event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      isLoadingDemoData: true,
      demoDataError: null,
    ));

    try {
      await _recordsRepository.loadDemoData();

      final hasDemoData = await _recordsRepository.hasDemoData();

      emit(state.copyWith(
        isLoadingDemoData: false,
        hasDemoData: hasDemoData,
        demoDataError: null,
      ));

      await _loadResources(emit);
    } catch (e) {
      emit(state.copyWith(
        isLoadingDemoData: false,
        demoDataError: e.toString(),
      ));
    }
  }

  Future<void> _onClearDemoData(
    ClearDemoData event,
    Emitter<RecordsState> emit,
  ) async {
    try {
      await _recordsRepository.clearDemoData();

      emit(state.copyWith(
        hasDemoData: false,
        demoDataError: null,
      ));

      await _loadResources(emit);
    } catch (e) {
      emit(state.copyWith(
        demoDataError: e.toString(),
      ));
    }
  }

  Future<void> _onSearch(
    RecordsSearch event,
    Emitter<RecordsState> emit,
  ) async {
    final query = event.query.trim();
    emit(state.copyWith(searchQuery: query));

    _searchDebounceTimer?.cancel();

    if (query.isEmpty) {
      emit(state.copyWith(
        resources: [],
        hasMorePages: true,
      ));
      await _loadResources(emit);
      return;
    }

    if (query.length < 2) {
      return;
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!isClosed) {
        add(RecordsSearchExecuted(query));
      }
    });
  }

  Future<void> _onSearchExecuted(
    RecordsSearchExecuted event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      resources: [],
      hasMorePages: false,
    ));
    await _loadResources(emit);
  }

  _onRecordsSharePressed(
    RecordsSharePressed event,
    Emitter<RecordsState> emit,
  ) async {
    Uint8List ipsBytes =
        await _recordsRepository.buildIpsExport(sourceId: state.sourceId);

    File pdfFile = await File(
      '${(await getTemporaryDirectory()).path}/ips-export-${DateTime.now().toIso8601String()}.pdf',
    ).writeAsBytes(ipsBytes);

    SharePlus.instance.share(ShareParams(files: [XFile(pdfFile.path)]));
  }
}
