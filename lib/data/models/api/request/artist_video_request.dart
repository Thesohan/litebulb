import 'package:json_annotation/json_annotation.dart';
part 'artist_video_request.g.dart';
@JsonSerializable()
class ArtistVideoRequest{
final String artistid;
final String videoid;
final String userid;

  ArtistVideoRequest({this.artistid, this.videoid, this.userid,});


factory ArtistVideoRequest.fromJson(Map<String, dynamic> json) =>
    _$ArtistVideoRequestFromJson(json);

Map<String, dynamic> toJson() => _$ArtistVideoRequestToJson(this);

}