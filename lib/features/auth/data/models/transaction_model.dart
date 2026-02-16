import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

enum TransactionType {
  @JsonValue("credit") credit,
  @JsonValue("debit") debit,
}

 @JsonSerializable()
  class TransactionRecord {
    final String id;
    final String organisationId;
    final double amount;
    final TransactionType type;
    final String description;
    final DateTime date;
    final String? category;

    TransactionRecord({
      required this.id,
      required this.organisationId,
      required this.amount,
      required this.type,
      required this.description,
      required this.date,
      this.category,
    });

    factory TransactionRecord.fromJson(Map<String, dynamic> json) => _$TransactionRecordFromJson(json);
    Map<String, dynamic> toJson() => _$TransactionRecordToJson(this);
    
  }