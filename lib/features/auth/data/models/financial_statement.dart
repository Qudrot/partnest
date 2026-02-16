import 'package:json_annotation/json_annotation.dart';

part 'financial_statement.g.dart';

enum ProcessingStatus {
  @JsonValue("pending") pending,
  @JsonValue("processing") processing,
  @JsonValue("completed") completed,
  @JsonValue("failed") failed,
}

@JsonSerializable()
class FinancialStatement {
  final String id;
  final String organisationId;
  final String fileUrl;
  final DateTime uploadDate;
  final ProcessingStatus status;
  final String? parsingError;

  FinancialStatement({
    required this.id,
    required this.organisationId,
    required this.fileUrl,
    required this.uploadDate,
    required this.status,
    this.parsingError,
  });

  factory FinancialStatement.fromJson(Map<String, dynamic> json) => _$FinancialStatementFromJson(json);
  Map<String, dynamic> toJson() => _$FinancialStatementToJson(this);

}