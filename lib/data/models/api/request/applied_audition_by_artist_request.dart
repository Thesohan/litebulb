import 'package:json_annotation/json_annotation.dart';

part 'applied_audition_by_artist_request.g.dart';

@JsonSerializable()
class AppliedAuditionByArtistRequest {
  final String artistid;
  final String status;

  AppliedAuditionByArtistRequest({
    this.artistid,
    this.status,
  });

  factory AppliedAuditionByArtistRequest.fromJson(Map<String, dynamic> json) =>
      _$AppliedAuditionByArtistRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedAuditionByArtistRequestToJson(this);
}
