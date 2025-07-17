// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  image: json['image'] as String?,
  role: json['role'] as String,
  license: json['license'] as String?,
  premium: json['premium'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'image': instance.image,
  'role': instance.role,
  'license': instance.license,
  'premium': instance.premium,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
