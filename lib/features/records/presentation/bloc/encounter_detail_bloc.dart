import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:injectable/injectable.dart';

part 'encounter_detail_event.dart';
part 'encounter_detail_state.dart';
part 'encounter_detail_bloc.freezed.dart';

@injectable
class EncounterDetailBloc
    extends Bloc<EncounterDetailEvent, EncounterDetailState> {
  final RecordsRepository _recordsService;

  EncounterDetailBloc(this._recordsService)
      : super(const EncounterDetailState()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(_Load event, Emitter<EncounterDetailState> emit) async {
    emit(state.copyWith(status: EncounterDetailStatus.loading));
    try {
      final resources = await _recordsService
          .getRelatedResourcesForEncounter(event.encounterId);
      emit(
        state.copyWith(
          status: EncounterDetailStatus.success,
          relatedResources: resources,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: EncounterDetailStatus.failure, error: e.toString()));
    }
  }
}
