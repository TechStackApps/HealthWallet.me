import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/attachment.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';

part 'document_reference.freezed.dart';
part 'document_reference.g.dart';

@freezed
class DocumentReference with _$DocumentReference {
  factory DocumentReference({
    String? id,
    CodeableConcept? code,
    String? title,
    String? description,
    String? status,
    CodeableConcept? category,
    @JsonKey(name: 'doc_status') String? docStatus,
    @JsonKey(name: 'type_coding') Coding? typeCoding,
    @JsonKey(name: 'class_coding') Coding? classCoding,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'security_label_coding') Coding? securityLabelCoding,
    List<Attachment>? content,
    DocumentReferenceContext? context,
  }) = _DocumentReference;

  factory DocumentReference.fromJson(Map<String, dynamic> json) =>
      _$DocumentReferenceFromJson(json);
}

@freezed
class DocumentReferenceContext with _$DocumentReferenceContext {
  factory DocumentReferenceContext({
    Coding? eventCoding,
    Coding? facilityTypeCoding,
    Coding? practiceSettingCoding,
    String? periodStart,
    String? periodEnd,
  }) = _DocumentReferenceContext;

  factory DocumentReferenceContext.fromJson(Map<String, dynamic> json) =>
      _$DocumentReferenceContextFromJson(json);
}
