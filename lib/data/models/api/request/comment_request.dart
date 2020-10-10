import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_request.g.dart';
@JsonSerializable()
class CommentRequest{
final String object_id;

  CommentRequest({@required this.object_id}):assert(object_id!=null);

factory CommentRequest.fromJson(Map<String, dynamic> json) =>
    _$CommentRequestFromJson(json);

Map<String, dynamic> toJson() => _$CommentRequestToJson(this);

}