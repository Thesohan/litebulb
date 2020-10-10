// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_of_subscriber_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoOfSubscriberResponse _$NoOfSubscriberResponseFromJson(
    Map<String, dynamic> json) {
  return NoOfSubscriberResponse(
    message: json['message'] as String,
    success: json['success'] as String,
    data: json['data'] as int,
  );
}

Map<String, dynamic> _$NoOfSubscriberResponseToJson(
        NoOfSubscriberResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };
