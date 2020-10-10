import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'like_video_request.g.dart';

@JsonSerializable()
class LikeVideoRequest {
  final String vid;
  final String userid;

  LikeVideoRequest({
    @required this.vid,
    @required this.userid,
  }) : assert(vid != null && userid != null);


  factory LikeVideoRequest.fromJson(Map<String, dynamic> json) =>
      _$LikeVideoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LikeVideoRequestToJson(this);
}
