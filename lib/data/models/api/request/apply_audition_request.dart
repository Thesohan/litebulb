import 'package:json_annotation/json_annotation.dart';
part 'apply_audition_request.g.dart';

@JsonSerializable()
class ApplyAuditionRequest {
  final String agencyid;
  final String artistid;
  final String postid;
  final String status;

  ApplyAuditionRequest(
      {this.agencyid, this.artistid, this.postid, this.status});

  factory ApplyAuditionRequest.fromJson(Map<String, dynamic> json) =>
      _$ApplyAuditionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyAuditionRequestToJson(this);

  ApplyAuditionRequest copyWith(
      {String agencyid, String artistid, String postid, String status}) {
    return ApplyAuditionRequest(
      agencyid: agencyid ?? this.agencyid,
      postid: postid ?? this.postid,
      status: status ?? this.status,
      artistid: artistid ?? this.artistid,
    );
  }
}
