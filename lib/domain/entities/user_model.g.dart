// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionModel _$UserSessionModelFromJson(Map<String, dynamic> json) =>
    UserSessionModel(
      json['displayName'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserSessionModelToJson(UserSessionModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'displayName': instance.displayName,
    };
