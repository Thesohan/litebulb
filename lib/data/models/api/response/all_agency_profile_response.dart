import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
part 'all_agency_profile_response.g.dart';

@JsonSerializable()
class AllAgencyProfileResponse {
  final List<AgencyProfileResponse> data;
  final String message;
  final String success;

  AllAgencyProfileResponse({
    this.data,
    this.message,
    this.success,
  });

  factory AllAgencyProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$AllAgencyProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllAgencyProfileResponseToJson(this);
}
