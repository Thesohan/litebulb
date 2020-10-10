import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
part 'artist_all_video_response.g.dart';

@JsonSerializable()
class ArtistAllVideoResponse {
  final List<ArtistVideoResponse> data;
  final String message;
  final String success;

  ArtistAllVideoResponse({this.data, this.message, this.success,});

  factory ArtistAllVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistAllVideoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistAllVideoResponseToJson(this);
}
