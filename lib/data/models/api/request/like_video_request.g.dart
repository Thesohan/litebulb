// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_video_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeVideoRequest _$LikeVideoRequestFromJson(Map<String, dynamic> json) {
  return LikeVideoRequest(
    vid: json['vid'] as String,
    userid: json['userid'] as String,
  );
}

Map<String, dynamic> _$LikeVideoRequestToJson(LikeVideoRequest instance) =>
    <String, dynamic>{
      'vid': instance.vid,
      'userid': instance.userid,
    };
