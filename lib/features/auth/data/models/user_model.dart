import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserRole {
    @JsonValue("admin") admin,
    @JsonValue("sme") sme,
    @JsonValue("investor") investor,
}

@JsonSerializable()
class UserModel {
    final String id;
    final String email;
    final String name;
    final UserRole role;
    final String? profilePicture;
    final bool profileCompleted;
    final String? position;
    final String? investorType;
    final String? company;
    final String? investmentRange;
    final List<String>? sectors;

    UserModel({
        required this.id,
        required this.email,
        required this.name,
        required this.role,
        this.profilePicture,
        this.profileCompleted = false,
        this.position,
        this.investorType,
        this.company,
        this.investmentRange,
        this.sectors,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
    Map<String, dynamic> toJson() => _$UserModelToJson(this);
    
}
