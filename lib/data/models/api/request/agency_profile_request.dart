import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agency_profile_request.g.dart';

@JsonSerializable()
class AgencyProfileRequest {
  final String username;
  // ignore: non_constant_identifier_names
  final String artist_id;

  // ignore: non_constant_identifier_names
  AgencyProfileRequest( {@required this.username,this.artist_id,}) : assert(username != null);
  factory AgencyProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$AgencyProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyProfileRequestToJson(this);
}
