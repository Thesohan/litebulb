// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentModel _$AddCommentModelFromJson(Map<String, dynamic> json) {
  return AddCommentModel(
    object_id: json['object_id'] as String,
    comment_id: json['comment_id'] as String,
    sender_username: json['sender_username'] as String,
    reply_id: json['reply_id'] as String,
    comment_text: json['comment_text'] as String,
    reply: json['reply'] as String,
    rating_cache: json['rating_cache'] as String,
    access_key: json['access_key'] as String,
    visible: json['visible'] as String,
  );
}

Map<String, dynamic> _$AddCommentModelToJson(AddCommentModel instance) =>
    <String, dynamic>{
      'object_id': instance.object_id,
      'comment_id': instance.comment_id,
      'sender_username': instance.sender_username,
      'reply_id': instance.reply_id,
      'comment_text': instance.comment_text,
      'reply': instance.reply,
      'rating_cache': instance.rating_cache,
      'access_key': instance.access_key,
      'visible': instance.visible,
    };
