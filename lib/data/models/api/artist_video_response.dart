import 'package:json_annotation/json_annotation.dart';
part 'artist_video_response.g.dart';

@JsonSerializable()
class ArtistVideoResponse {
  final String id;
  final String artist_id;
  final String title;
  final String Category;
  final String description;
  final String video_id;
  final String video;
  final String thumbnail;
  final String location;
  final String thumbnail_url;
  final String tags;
  final String uploaded_at;
  final String is_safe;
  final String is_public;
  final String is_liked;
  final String no_oflikes;
  ArtistVideoResponse({
    this.id,
    this.artist_id,
    this.title,
    this.Category,
    this.description,
    this.video_id,
    this.video,
    this.thumbnail,
    this.location,
    this.thumbnail_url,
    this.tags,
    this.uploaded_at,
    this.is_safe,
    this.is_public,
    this.is_liked,
    this.no_oflikes,
  });

  factory ArtistVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistVideoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistVideoResponseToJson(this);
}
