import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
part 'blocked_agency_profile_response.g.dart';
@JsonSerializable()
class BlockedAgencyProfileResponse {
 final String success;
 final List<List<AgencyProfileResponse>> data;
 final String message;

  BlockedAgencyProfileResponse({this.success, this.data, this.message});


 factory BlockedAgencyProfileResponse.fromJson(Map<String, dynamic> json) =>
     _$BlockedAgencyProfileResponseFromJson(json);

 Map<String, dynamic> toJson() => _$BlockedAgencyProfileResponseToJson(this);

}