// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleMessageResponse _$SimpleMessageResponseFromJson(
    Map<String, dynamic> json) {
  return SimpleMessageResponse(
    json['message'] as String,
    json['success'] as String,
  );
}

Map<String, dynamic> _$SimpleMessageResponseToJson(
        SimpleMessageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
    };
