import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String role;
  final String? license;
  final bool premium;
  final String createdAt;
  final String? updatedAt;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.role,
    this.license,
    required this.premium,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
