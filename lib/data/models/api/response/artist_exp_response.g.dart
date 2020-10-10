// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_exp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpOrProResponse _$ExpOrProResponseFromJson(Map<String, dynamic> json) {
  return ExpOrProResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ArtistExperienceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: json['success'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ExpOrProResponseToJson(ExpOrProResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
