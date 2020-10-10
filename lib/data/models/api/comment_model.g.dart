// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    comment_id: json['comment_id'] as String,
    sender_id: json['sender_id'] as String,
    Fullname: json['Fullname'] as String,
    is_artist: json['is_artist'] as String,
    profile_url: json['profile_url'] as String,
    Message: json['Message'] as String,
    Timestamp: json['Timestamp'] as String,
    Replies: (json['Replies'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'comment_id': instance.comment_id,
      'sender_id': instance.sender_id,
      'Fullname': instance.Fullname,
      'is_artist': instance.is_artist,
      'profile_url': instance.profile_url,
      'Message': instance.Message,
      'Timestamp': instance.Timestamp,
      'Replies': instance.Replies,
    };
