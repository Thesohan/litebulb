// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audition_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditionListResponse _$AuditionListResponseFromJson(Map<String, dynamic> json) {
  return AuditionListResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AuditionResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as String,
  );
}

Map<String, dynamic> _$AuditionListResponseToJson(
        AuditionListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };
