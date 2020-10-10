import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_profile_request.g.dart';
@JsonSerializable()
class CommenterProfileRequest{
  final String user_id;
  final String self_id;

  CommenterProfileRequest({@required this.user_id, this.self_id});

  factory CommenterProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$CommenterProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommenterProfileRequestToJson(this);

  CommenterProfileRequest copyWith({String user_id,String self_id}){
    return CommenterProfileRequest(
    user_id:user_id??this.user_id,
      self_id: self_id??this.self_id
    );
}
}