import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:injectable/injectable.dart';

part 'fhir_mapper_event.dart';
part 'fhir_mapper_state.dart';
part 'fhir_mapper_bloc.freezed.dart';

@Injectable()
class FhirMapperBloc extends Bloc<FhirMapperEvent, FhirMapperState> {
  FhirMapperBloc(this._repository) : super(const FhirMapperState()) {
    on<FhirMappingInitiated>(_onFhirMappingInitiated);
    on<FhirMapperResourceChanged>(_onFhirMapperResourceChanged);
  }

  final ScanRepository _repository;

  void _onFhirMappingInitiated(
    FhirMappingInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    emit(state.copyWith(status: FhirMapperStatus.loading));

    List<MappingResource> resources =
        await _repository.mapResources(event.text);

    emit(state.copyWith(
      status: FhirMapperStatus.success,
      resources: resources,
    ));
  }

  void _onFhirMapperResourceChanged(
    FhirMapperResourceChanged event,
    Emitter<FhirMapperState> emit,
  ) {
    MappingResource updatedResource = state.resources[event.index].copyWithMap({
      event.propertyKey: event.newValue,
    });

    final newResources = [...state.resources];
    newResources[event.index] = updatedResource;

    emit(state.copyWith(resources: newResources));
  }
}
