import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_comment_model.g.dart';
@JsonSerializable()
class AddCommentModel {
  final String object_id;
  final String comment_id;
  final String sender_username;
  final String reply_id;
  final String comment_text;
  final String reply;
  final String rating_cache;
  final String access_key;
  final String visible;

  AddCommentModel({
    @required this.object_id,
    this.comment_id,
   @required this.sender_username,
    this.reply_id,
    this.comment_text,
    this.reply,
    this.rating_cache,
    this.access_key,
    this.visible,
  });

  factory AddCommentModel.fromJson(Map<String, dynamic> json) =>
      _$AddCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentModelToJson(this);

}
