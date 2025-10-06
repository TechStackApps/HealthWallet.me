import 'package:health_wallet/features/sync/data/dto/source_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:injectable/injectable.dart';

abstract class SourceMapper {
  Source mapToEntity(SourceDto dto);
  List<Source> mapToEntities(List<SourceDto> dtos);
}

@Injectable(as: SourceMapper)
class SourceMapperImpl implements SourceMapper {
  @override
  Source mapToEntity(SourceDto dto) {
    final platformType = dto.platformType;
    final display = dto.display;

    String? labelSource = display?.isNotEmpty == true ? display : null;
    if (platformType == 'fasten') {
      labelSource ??= 'Fasten Health';
    } else if (platformType == 'manual') {
      labelSource ??= 'Manual Entry';
    }

    DateTime? createdAt;
    DateTime? updatedAt;

    if (dto.createdAt != null) {
      try {
        createdAt = DateTime.parse(dto.createdAt!);
      } catch (e) {}
    }

    if (dto.updatedAt != null) {
      try {
        updatedAt = DateTime.parse(dto.updatedAt!);
      } catch (e) {}
    }

    return Source(
      id: dto.id,
      name: platformType,
      logo: dto.logo,
      labelSource: labelSource,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Source> mapToEntities(List<SourceDto> dtos) {
    return dtos.map(mapToEntity).toList();
  }
}
