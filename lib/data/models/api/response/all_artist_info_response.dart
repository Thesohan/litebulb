import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
part 'all_artist_info_response.g.dart';

@JsonSerializable()
class AllArtistInfoResponse {
  final List<ArtistProfileResponse> data;
  final String message;
  final String success;

  AllArtistInfoResponse({
    this.data,
    this.message,
    this.success,
  });

  factory AllArtistInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AllArtistInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllArtistInfoResponseToJson(this);
}
