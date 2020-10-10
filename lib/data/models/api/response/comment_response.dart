import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/comment_model.dart';
part 'comment_response.g.dart';
@JsonSerializable()
class CommentResponse{
  final List<CommentModel> data;
  final String success;
  final String message;

  CommentResponse({this.data, this.success, this.message});



  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}