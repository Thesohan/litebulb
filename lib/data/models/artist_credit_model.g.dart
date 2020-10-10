// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_credit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditModel _$CreditModelFromJson(Map<String, dynamic> json) {
  return CreditModel(
    p_id: json['p_id'] as String,
    id: json['id'] as String,
    award_name: json['award_name'] as String,
    role: json['role'] as String,
    award_details: json['award_details'] as String,
  );
}

Map<String, dynamic> _$CreditModelToJson(CreditModel instance) =>
    <String, dynamic>{
      'p_id': instance.p_id,
      'id': instance.id,
      'award_name': instance.award_name,
      'role': instance.role,
      'award_details': instance.award_details,
    };
