// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explanation_of_benefit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExplanationOfBenefitImpl _$$ExplanationOfBenefitImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      codeText: json['code_text'] as String?,
      codeId: json['code_id'] as String?,
      codeSystem: json['code_system'] as String?,
      disposition: json['disposition'] as String?,
      created: json['created'] as String?,
      insurer: json['insurer'] == null
          ? null
          : Reference.fromJson(json['insurer'] as Map<String, dynamic>),
      totalBenefit: (json['totalBenefit'] as num?)?.toDouble(),
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      hasInsurer: json['hasInsurer'] as bool?,
      hasType: json['hasType'] as bool?,
      type: (json['type'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasServices: json['hasServices'] as bool?,
      hasInformation: json['hasInformation'] as bool?,
      resourceStatus: json['resourceStatus'] as String?,
      useCode: json['useCode'] as String?,
      patient: json['patient'] == null
          ? null
          : Reference.fromJson(json['patient'] as Map<String, dynamic>),
      provider: json['provider'] == null
          ? null
          : Reference.fromJson(json['provider'] as Map<String, dynamic>),
      insurance: (json['insurance'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitInsurance.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitTotal.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasTotal: json['hasTotal'] as bool?,
      diagnosis: (json['diagnosis'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitDiagnosis.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasDiagnosis: json['hasDiagnosis'] as bool?,
      supportingInfo: (json['supportingInfo'] as List<dynamic>?)
          ?.map((e) => ExplanationOfBenefitSupportingInfo.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      hasSupportingInfo: json['hasSupportingInfo'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasItems: json['hasItems'] as bool?,
      payment: (json['payment'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      billablePeriod: (json['billablePeriod'] as List<dynamic>?)
          ?.map((e) => ExplanationOfBenefitBillablePeriod.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      identifier: (json['identifier'] as List<dynamic>?)
          ?.map((e) => ExplanationOfBenefitIdentifier.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      outcome: json['outcome'] as String?,
      careTeam: (json['careTeam'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitCareTeam.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasCareTeam: json['hasCareTeam'] as bool?,
      payeeType: json['payeeType'] == null
          ? null
          : CodeableConcept.fromJson(json['payeeType'] as Map<String, dynamic>),
      payeeParty: json['payeeParty'] == null
          ? null
          : Reference.fromJson(json['payeeParty'] as Map<String, dynamic>),
      related: (json['related'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitRelated.fromJson(e as Map<String, dynamic>))
          .toList(),
      procedures: (json['procedures'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitProcedure.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExplanationOfBenefitImplToJson(
        _$ExplanationOfBenefitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'code_text': instance.codeText,
      'code_id': instance.codeId,
      'code_system': instance.codeSystem,
      'disposition': instance.disposition,
      'created': instance.created,
      'insurer': instance.insurer,
      'totalBenefit': instance.totalBenefit,
      'totalCost': instance.totalCost,
      'hasInsurer': instance.hasInsurer,
      'hasType': instance.hasType,
      'type': instance.type,
      'hasServices': instance.hasServices,
      'hasInformation': instance.hasInformation,
      'resourceStatus': instance.resourceStatus,
      'useCode': instance.useCode,
      'patient': instance.patient,
      'provider': instance.provider,
      'insurance': instance.insurance,
      'total': instance.total,
      'hasTotal': instance.hasTotal,
      'diagnosis': instance.diagnosis,
      'hasDiagnosis': instance.hasDiagnosis,
      'supportingInfo': instance.supportingInfo,
      'hasSupportingInfo': instance.hasSupportingInfo,
      'items': instance.items,
      'hasItems': instance.hasItems,
      'payment': instance.payment,
      'billablePeriod': instance.billablePeriod,
      'identifier': instance.identifier,
      'outcome': instance.outcome,
      'careTeam': instance.careTeam,
      'hasCareTeam': instance.hasCareTeam,
      'payeeType': instance.payeeType,
      'payeeParty': instance.payeeParty,
      'related': instance.related,
      'procedures': instance.procedures,
    };

_$ExplanationOfBenefitInsuranceImpl
    _$$ExplanationOfBenefitInsuranceImplFromJson(Map<String, dynamic> json) =>
        _$ExplanationOfBenefitInsuranceImpl(
          focal: json['focal'] as bool?,
          coverage: json['coverage'] == null
              ? null
              : Reference.fromJson(json['coverage'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ExplanationOfBenefitInsuranceImplToJson(
        _$ExplanationOfBenefitInsuranceImpl instance) =>
    <String, dynamic>{
      'focal': instance.focal,
      'coverage': instance.coverage,
    };

_$ExplanationOfBenefitTotalImpl _$$ExplanationOfBenefitTotalImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitTotalImpl(
      category: json['category'] == null
          ? null
          : CodeableConcept.fromJson(json['category'] as Map<String, dynamic>),
      amount: json['amount'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExplanationOfBenefitTotalImplToJson(
        _$ExplanationOfBenefitTotalImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amount': instance.amount,
    };

_$ExplanationOfBenefitMoneyImpl _$$ExplanationOfBenefitMoneyImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitMoneyImpl(
      value: (json['value'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$$ExplanationOfBenefitMoneyImplToJson(
        _$ExplanationOfBenefitMoneyImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
    };

_$ExplanationOfBenefitDiagnosisImpl
    _$$ExplanationOfBenefitDiagnosisImplFromJson(Map<String, dynamic> json) =>
        _$ExplanationOfBenefitDiagnosisImpl(
          sequence: (json['sequence'] as num?)?.toInt(),
          diagnosisCodeableConcept: json['diagnosisCodeableConcept'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['diagnosisCodeableConcept'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ExplanationOfBenefitDiagnosisImplToJson(
        _$ExplanationOfBenefitDiagnosisImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'diagnosisCodeableConcept': instance.diagnosisCodeableConcept,
    };

_$ExplanationOfBenefitSupportingInfoImpl
    _$$ExplanationOfBenefitSupportingInfoImplFromJson(
            Map<String, dynamic> json) =>
        _$ExplanationOfBenefitSupportingInfoImpl(
          sequence: (json['sequence'] as num?)?.toInt(),
          category: json['category'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['category'] as Map<String, dynamic>),
          code: json['code'] == null
              ? null
              : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
          timingDate: json['timingDate'] as String?,
          timingPeriod: json['timingPeriod'] as String?,
          valueBoolean: json['valueBoolean'] as bool?,
          valueString: json['valueString'] as String?,
          valueQuantity: (json['valueQuantity'] as num?)?.toInt(),
          valueAttachment: json['valueAttachment'] == null
              ? null
              : Attachment.fromJson(
                  json['valueAttachment'] as Map<String, dynamic>),
          valueReference: json['valueReference'] == null
              ? null
              : Reference.fromJson(
                  json['valueReference'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ExplanationOfBenefitSupportingInfoImplToJson(
        _$ExplanationOfBenefitSupportingInfoImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'category': instance.category,
      'code': instance.code,
      'timingDate': instance.timingDate,
      'timingPeriod': instance.timingPeriod,
      'valueBoolean': instance.valueBoolean,
      'valueString': instance.valueString,
      'valueQuantity': instance.valueQuantity,
      'valueAttachment': instance.valueAttachment,
      'valueReference': instance.valueReference,
    };

_$ExplanationOfBenefitItemImpl _$$ExplanationOfBenefitItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitItemImpl(
      sequence: (json['sequence'] as num?)?.toInt(),
      careTeamSequence: (json['careTeamSequence'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      diagnosisSequence: (json['diagnosisSequence'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      procedureSequence: (json['procedureSequence'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      informationSequence: (json['informationSequence'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      revenue: json['revenue'] == null
          ? null
          : CodeableConcept.fromJson(json['revenue'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CodeableConcept.fromJson(json['category'] as Map<String, dynamic>),
      productOrService: json['productOrService'] == null
          ? null
          : CodeableConcept.fromJson(
              json['productOrService'] as Map<String, dynamic>),
      modifier: (json['modifier'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      programCode: (json['programCode'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      servicedDate: json['servicedDate'] as String?,
      servicedPeriod: json['servicedPeriod'] as String?,
      locationCodeableConcept: json['locationCodeableConcept'] == null
          ? null
          : CodeableConcept.fromJson(
              json['locationCodeableConcept'] as Map<String, dynamic>),
      locationAddress: json['locationAddress'] == null
          ? null
          : Address.fromJson(json['locationAddress'] as Map<String, dynamic>),
      locationReference: json['locationReference'] == null
          ? null
          : Reference.fromJson(
              json['locationReference'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: json['unitPrice'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['unitPrice'] as Map<String, dynamic>),
      factor: (json['factor'] as num?)?.toDouble(),
      net: json['net'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['net'] as Map<String, dynamic>),
      udi: (json['udi'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      adjudication: (json['adjudication'] as List<dynamic>?)
          ?.map((e) => ExplanationOfBenefitAdjudication.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExplanationOfBenefitItemImplToJson(
        _$ExplanationOfBenefitItemImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'careTeamSequence': instance.careTeamSequence,
      'diagnosisSequence': instance.diagnosisSequence,
      'procedureSequence': instance.procedureSequence,
      'informationSequence': instance.informationSequence,
      'revenue': instance.revenue,
      'category': instance.category,
      'productOrService': instance.productOrService,
      'modifier': instance.modifier,
      'programCode': instance.programCode,
      'servicedDate': instance.servicedDate,
      'servicedPeriod': instance.servicedPeriod,
      'locationCodeableConcept': instance.locationCodeableConcept,
      'locationAddress': instance.locationAddress,
      'locationReference': instance.locationReference,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'factor': instance.factor,
      'net': instance.net,
      'udi': instance.udi,
      'adjudication': instance.adjudication,
      'detail': instance.detail,
    };

_$ExplanationOfBenefitAdjudicationImpl
    _$$ExplanationOfBenefitAdjudicationImplFromJson(
            Map<String, dynamic> json) =>
        _$ExplanationOfBenefitAdjudicationImpl(
          category: json['category'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['category'] as Map<String, dynamic>),
          reason: json['reason'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['reason'] as Map<String, dynamic>),
          amount: json['amount'] == null
              ? null
              : ExplanationOfBenefitMoney.fromJson(
                  json['amount'] as Map<String, dynamic>),
          value: (json['value'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$$ExplanationOfBenefitAdjudicationImplToJson(
        _$ExplanationOfBenefitAdjudicationImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'reason': instance.reason,
      'amount': instance.amount,
      'value': instance.value,
    };

_$ExplanationOfBenefitDetailImpl _$$ExplanationOfBenefitDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitDetailImpl(
      sequence: (json['sequence'] as num?)?.toInt(),
      revenue: json['revenue'] == null
          ? null
          : CodeableConcept.fromJson(json['revenue'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CodeableConcept.fromJson(json['category'] as Map<String, dynamic>),
      productOrService: json['productOrService'] == null
          ? null
          : CodeableConcept.fromJson(
              json['productOrService'] as Map<String, dynamic>),
      modifier: (json['modifier'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      programCode: (json['programCode'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: json['unitPrice'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['unitPrice'] as Map<String, dynamic>),
      factor: (json['factor'] as num?)?.toDouble(),
      net: json['net'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['net'] as Map<String, dynamic>),
      udi: (json['udi'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      adjudication: (json['adjudication'] as List<dynamic>?)
          ?.map((e) => ExplanationOfBenefitAdjudication.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      subDetail: (json['subDetail'] as List<dynamic>?)
          ?.map((e) =>
              ExplanationOfBenefitSubDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExplanationOfBenefitDetailImplToJson(
        _$ExplanationOfBenefitDetailImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'revenue': instance.revenue,
      'category': instance.category,
      'productOrService': instance.productOrService,
      'modifier': instance.modifier,
      'programCode': instance.programCode,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'factor': instance.factor,
      'net': instance.net,
      'udi': instance.udi,
      'adjudication': instance.adjudication,
      'subDetail': instance.subDetail,
    };

_$ExplanationOfBenefitSubDetailImpl
    _$$ExplanationOfBenefitSubDetailImplFromJson(Map<String, dynamic> json) =>
        _$ExplanationOfBenefitSubDetailImpl(
          sequence: (json['sequence'] as num?)?.toInt(),
          revenue: json['revenue'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['revenue'] as Map<String, dynamic>),
          category: json['category'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['category'] as Map<String, dynamic>),
          productOrService: json['productOrService'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['productOrService'] as Map<String, dynamic>),
          modifier: (json['modifier'] as List<dynamic>?)
              ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
              .toList(),
          programCode: (json['programCode'] as List<dynamic>?)
              ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
              .toList(),
          quantity: (json['quantity'] as num?)?.toInt(),
          unitPrice: json['unitPrice'] == null
              ? null
              : ExplanationOfBenefitMoney.fromJson(
                  json['unitPrice'] as Map<String, dynamic>),
          factor: (json['factor'] as num?)?.toDouble(),
          net: json['net'] == null
              ? null
              : ExplanationOfBenefitMoney.fromJson(
                  json['net'] as Map<String, dynamic>),
          udi: (json['udi'] as List<dynamic>?)
              ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
              .toList(),
          adjudication: (json['adjudication'] as List<dynamic>?)
              ?.map((e) => ExplanationOfBenefitAdjudication.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ExplanationOfBenefitSubDetailImplToJson(
        _$ExplanationOfBenefitSubDetailImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'revenue': instance.revenue,
      'category': instance.category,
      'productOrService': instance.productOrService,
      'modifier': instance.modifier,
      'programCode': instance.programCode,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'factor': instance.factor,
      'net': instance.net,
      'udi': instance.udi,
      'adjudication': instance.adjudication,
    };

_$ExplanationOfBenefitPaymentImpl _$$ExplanationOfBenefitPaymentImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitPaymentImpl(
      type: json['type'] == null
          ? null
          : CodeableConcept.fromJson(json['type'] as Map<String, dynamic>),
      adjustment: json['adjustment'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['adjustment'] as Map<String, dynamic>),
      adjustmentReason: json['adjustmentReason'] == null
          ? null
          : CodeableConcept.fromJson(
              json['adjustmentReason'] as Map<String, dynamic>),
      date: json['date'] as String?,
      amount: json['amount'] == null
          ? null
          : ExplanationOfBenefitMoney.fromJson(
              json['amount'] as Map<String, dynamic>),
      identifier: json['identifier'] == null
          ? null
          : Identifier.fromJson(json['identifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExplanationOfBenefitPaymentImplToJson(
        _$ExplanationOfBenefitPaymentImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'adjustment': instance.adjustment,
      'adjustmentReason': instance.adjustmentReason,
      'date': instance.date,
      'amount': instance.amount,
      'identifier': instance.identifier,
    };

_$ExplanationOfBenefitBillablePeriodImpl
    _$$ExplanationOfBenefitBillablePeriodImplFromJson(
            Map<String, dynamic> json) =>
        _$ExplanationOfBenefitBillablePeriodImpl(
          start: json['start'] as String?,
          end: json['end'] as String?,
        );

Map<String, dynamic> _$$ExplanationOfBenefitBillablePeriodImplToJson(
        _$ExplanationOfBenefitBillablePeriodImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$ExplanationOfBenefitIdentifierImpl
    _$$ExplanationOfBenefitIdentifierImplFromJson(Map<String, dynamic> json) =>
        _$ExplanationOfBenefitIdentifierImpl(
          system: json['system'] as String?,
          value: json['value'] as String?,
        );

Map<String, dynamic> _$$ExplanationOfBenefitIdentifierImplToJson(
        _$ExplanationOfBenefitIdentifierImpl instance) =>
    <String, dynamic>{
      'system': instance.system,
      'value': instance.value,
    };

_$ExplanationOfBenefitCareTeamImpl _$$ExplanationOfBenefitCareTeamImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitCareTeamImpl(
      sequence: (json['sequence'] as num?)?.toInt(),
      provider: json['provider'] == null
          ? null
          : Reference.fromJson(json['provider'] as Map<String, dynamic>),
      responsible: json['responsible'] as bool?,
      role: json['role'] == null
          ? null
          : CodeableConcept.fromJson(json['role'] as Map<String, dynamic>),
      qualification: json['qualification'] == null
          ? null
          : CodeableConcept.fromJson(
              json['qualification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExplanationOfBenefitCareTeamImplToJson(
        _$ExplanationOfBenefitCareTeamImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'provider': instance.provider,
      'responsible': instance.responsible,
      'role': instance.role,
      'qualification': instance.qualification,
    };

_$ExplanationOfBenefitRelatedImpl _$$ExplanationOfBenefitRelatedImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplanationOfBenefitRelatedImpl(
      claim: json['claim'] == null
          ? null
          : Reference.fromJson(json['claim'] as Map<String, dynamic>),
      relationship: json['relationship'] == null
          ? null
          : CodeableConcept.fromJson(
              json['relationship'] as Map<String, dynamic>),
      reference: json['reference'] == null
          ? null
          : Identifier.fromJson(json['reference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExplanationOfBenefitRelatedImplToJson(
        _$ExplanationOfBenefitRelatedImpl instance) =>
    <String, dynamic>{
      'claim': instance.claim,
      'relationship': instance.relationship,
      'reference': instance.reference,
    };

_$ExplanationOfBenefitProcedureImpl
    _$$ExplanationOfBenefitProcedureImplFromJson(Map<String, dynamic> json) =>
        _$ExplanationOfBenefitProcedureImpl(
          sequence: (json['sequence'] as num?)?.toInt(),
          date: json['date'] as String?,
          procedureCodeableConcept: json['procedureCodeableConcept'] == null
              ? null
              : CodeableConcept.fromJson(
                  json['procedureCodeableConcept'] as Map<String, dynamic>),
          procedureReference: json['procedureReference'] == null
              ? null
              : Reference.fromJson(
                  json['procedureReference'] as Map<String, dynamic>),
          udi: (json['udi'] as List<dynamic>?)
              ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ExplanationOfBenefitProcedureImplToJson(
        _$ExplanationOfBenefitProcedureImpl instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'date': instance.date,
      'procedureCodeableConcept': instance.procedureCodeableConcept,
      'procedureReference': instance.procedureReference,
      'udi': instance.udi,
    };

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      contentType: json['contentType'] as String?,
      language: json['language'] as String?,
      data: json['data'] as String?,
      url: json['url'] as String?,
      size: (json['size'] as num?)?.toInt(),
      hash: json['hash'] as String?,
      title: json['title'] as String?,
      creation: json['creation'] as String?,
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'language': instance.language,
      'data': instance.data,
      'url': instance.url,
      'size': instance.size,
      'hash': instance.hash,
      'title': instance.title,
      'creation': instance.creation,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      use: json['use'] as String?,
      type: json['type'] as String?,
      text: json['text'] as String?,
      line: (json['line'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: json['city'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      period: json['period'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'use': instance.use,
      'type': instance.type,
      'text': instance.text,
      'line': instance.line,
      'city': instance.city,
      'district': instance.district,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'period': instance.period,
    };

_$IdentifierImpl _$$IdentifierImplFromJson(Map<String, dynamic> json) =>
    _$IdentifierImpl(
      use: json['use'] as String?,
      type: json['type'] == null
          ? null
          : CodeableConcept.fromJson(json['type'] as Map<String, dynamic>),
      system: json['system'] as String?,
      value: json['value'] as String?,
      period: json['period'] as String?,
      assigner: json['assigner'] == null
          ? null
          : Reference.fromJson(json['assigner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IdentifierImplToJson(_$IdentifierImpl instance) =>
    <String, dynamic>{
      'use': instance.use,
      'type': instance.type,
      'system': instance.system,
      'value': instance.value,
      'period': instance.period,
      'assigner': instance.assigner,
    };
