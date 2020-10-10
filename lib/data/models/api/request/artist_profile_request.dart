import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artist_profile_request.g.dart';

@JsonSerializable()
class ArtistProfileRequest {
  final String id;
  final String email;

  ArtistProfileRequest({@required this.id, @required this.email});

  factory ArtistProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$ArtistProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistProfileRequestToJson(this);
}
