// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditionRequest _$AuditionRequestFromJson(Map<String, dynamic> json) {
  return AuditionRequest(
    user_id: json['user_id'] as String,
    category: json['category'] as String,
    is_featured: json['is_featured'] as String,
    agency_id: json['agency_id'] as String,
  );
}

Map<String, dynamic> _$AuditionRequestToJson(AuditionRequest instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'category': instance.category,
      'is_featured': instance.is_featured,
      'agency_id': instance.agency_id,
    };
