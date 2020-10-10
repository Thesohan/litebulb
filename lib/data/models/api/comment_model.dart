import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';
@JsonSerializable()
class CommentModel{
  final String comment_id;
  final String sender_id;
  final String Fullname;
  final String is_artist;
  final String profile_url;
  final String Message;
  final String Timestamp;
  // ignore: non_constant_identifier_names
  final List<String> Replies;

  CommentModel({@required this.comment_id,@required this.sender_id, this.Fullname, this.is_artist, this.profile_url, this.Message, this.Timestamp,this.Replies,});



  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

@override
  String toString() {
    return super.toString();
  }
}