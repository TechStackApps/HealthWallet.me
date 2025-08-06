import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'document_reference.freezed.dart';

@freezed
class DocumentReference with _$DocumentReference implements IFhirResource {
  const DocumentReference._();

  factory DocumentReference({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    Identifier? masterIdentifier,
    List<Identifier>? identifier,
    DocumentReferenceStatus? status,
    CompositionStatus? docStatus,
    CodeableConcept? type,
    List<CodeableConcept>? category,
    Reference? subject,
    FhirInstant? fhirDate,
    List<Reference>? author,
    Reference? authenticator,
    Reference? custodian,
    List<DocumentReferenceRelatesTo>? relatesTo,
    FhirString? description,
    List<CodeableConcept>? securityLabel,
    List<DocumentReferenceContent>? content,
    DocumentReferenceContext? context,
  }) = _DocumentReference;

  @override
  FhirType get fhirType => FhirType.DocumentReference;

  factory DocumentReference.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirDocumentReference =
        fhir_r4.DocumentReference.fromJson(resourceJson);

    return DocumentReference(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirDocumentReference.text,
      masterIdentifier: fhirDocumentReference.masterIdentifier,
      identifier: fhirDocumentReference.identifier,
      status: fhirDocumentReference.status,
      docStatus: fhirDocumentReference.docStatus,
      type: fhirDocumentReference.type,
      category: fhirDocumentReference.category,
      subject: fhirDocumentReference.subject,
      fhirDate: fhirDocumentReference.date,
      author: fhirDocumentReference.author,
      authenticator: fhirDocumentReference.authenticator,
      custodian: fhirDocumentReference.custodian,
      relatesTo: fhirDocumentReference.relatesTo,
      description: fhirDocumentReference.description,
      securityLabel: fhirDocumentReference.securityLabel,
      content: fhirDocumentReference.content,
      context: fhirDocumentReference.context,
    );
  }
}
