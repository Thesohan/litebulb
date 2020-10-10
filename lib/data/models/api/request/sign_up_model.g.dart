// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) {
  return SignUpModel(
    json['email'] as String,
    json['password'] as String,
    json['whatsAppNumber'] as String,
    json['fullName'] as String,
  );
}

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'whatsAppNumber': instance.whatsAppNumber,
      'fullName': instance.fullName,
    };
