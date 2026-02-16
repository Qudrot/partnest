// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRecord _$TransactionRecordFromJson(Map<String, dynamic> json) =>
    TransactionRecord(
      id: json['id'] as String,
      organisationId: json['organisationId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$TransactionRecordToJson(TransactionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organisationId': instance.organisationId,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
};
