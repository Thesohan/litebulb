// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommenterProfileRequest _$CommenterProfileRequestFromJson(
    Map<String, dynamic> json) {
  return CommenterProfileRequest(
    user_id: json['user_id'] as String,
    self_id: json['self_id'] as String,
  );
}

Map<String, dynamic> _$CommenterProfileRequestToJson(
        CommenterProfileRequest instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'self_id': instance.self_id,
    };
