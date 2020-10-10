import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'logout_request.g.dart';

@JsonSerializable()
class LogoutRequest {
  final String email;

  LogoutRequest({@required this.email}):assert(email!=null);

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}
