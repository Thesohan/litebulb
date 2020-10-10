// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeRequest _$SubscribeRequestFromJson(Map<String, dynamic> json) {
  return SubscribeRequest(
    following_id: json['following_id'] as String,
    follower_id: json['follower_id'] as String,
  );
}

Map<String, dynamic> _$SubscribeRequestToJson(SubscribeRequest instance) =>
    <String, dynamic>{
      'following_id': instance.following_id,
      'follower_id': instance.follower_id,
    };
