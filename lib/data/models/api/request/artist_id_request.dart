import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artist_id_request.g.dart';

@JsonSerializable()
class ArtistIdRequest {
  final String artistid;

  ArtistIdRequest({@required this.artistid}) : assert(artistid != null);

  factory ArtistIdRequest.fromJson(Map<String, dynamic> json) =>
      _$ArtistIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistIdRequestToJson(this);
}
