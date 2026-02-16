// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_statement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialStatement _$FinancialStatementFromJson(Map<String, dynamic> json) =>
    FinancialStatement(
      id: json['id'] as String,
      organisationId: json['organisationId'] as String,
      fileUrl: json['fileUrl'] as String,
      uploadDate: DateTime.parse(json['uploadDate'] as String),
      status: $enumDecode(_$ProcessingStatusEnumMap, json['status']),
      parsingError: json['parsingError'] as String?,
    );

Map<String, dynamic> _$FinancialStatementToJson(FinancialStatement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organisationId': instance.organisationId,
      'fileUrl': instance.fileUrl,
      'uploadDate': instance.uploadDate.toIso8601String(),
      'status': _$ProcessingStatusEnumMap[instance.status]!,
      'parsingError': instance.parsingError,
    };

const _$ProcessingStatusEnumMap = {
  ProcessingStatus.pending: 'pending',
  ProcessingStatus.processing: 'processing',
  ProcessingStatus.completed: 'completed',
  ProcessingStatus.failed: 'failed',
};
