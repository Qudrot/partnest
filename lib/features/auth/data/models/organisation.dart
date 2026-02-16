import 'package:json_annotation/json_annotation.dart';

part 'organisation.g.dart';

@JsonSerializable()
class Organisation {
  final String id;
  final String name;
  final String registrationNumber;
  final String sector;
  final String description;
  final double? currentCredibilityScore;

  Organisation({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.sector,
    required this.description,
    this.currentCredibilityScore,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganisationToJson(this);

}