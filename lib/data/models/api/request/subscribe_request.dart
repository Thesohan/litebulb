import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subscribe_request.g.dart';

@JsonSerializable()
class SubscribeRequest {
  // ignore: non_constant_identifier_names
  final String following_id;
  // ignore: non_constant_identifier_names
  final String follower_id;

  // ignore: non_constant_identifier_names
  SubscribeRequest({@required this.following_id, @required this.follower_id})
      : assert(
          follower_id != null && following_id != null,
        );

  factory SubscribeRequest.fromJson(Map<String, dynamic> json) =>
      _$SubscribeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubscribeRequestToJson(this);
}
