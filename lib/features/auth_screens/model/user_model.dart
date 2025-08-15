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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle premium field conversion more robustly
    bool premiumValue = false;
    final premiumField = json['premium'];
    
    if (premiumField is bool) {
      premiumValue = premiumField;
    } else if (premiumField is String) {
      premiumValue = premiumField.toLowerCase() == 'true';
    } else if (premiumField is int) {
      premiumValue = premiumField == 1;
    }
    
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      role: json['role'] as String,
      license: json['license'] as String?,
      premium: premiumValue,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
