// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_audition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedAuditionResponse _$AppliedAuditionResponseFromJson(
    Map<String, dynamic> json) {
  return AppliedAuditionResponse(
    success: json['success'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AppliedAuditionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AppliedAuditionResponseToJson(
        AppliedAuditionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
