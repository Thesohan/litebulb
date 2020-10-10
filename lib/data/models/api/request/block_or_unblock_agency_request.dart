import 'package:json_annotation/json_annotation.dart';
part 'block_or_unblock_agency_request.g.dart';

@JsonSerializable()
class BlockOrUnblockAgencyRequest{
 final String agencyid;
 final String artistid;

  BlockOrUnblockAgencyRequest({this.agencyid, this.artistid}):assert(agencyid!=null && artistid!=null);

 factory BlockOrUnblockAgencyRequest.fromJson(Map<String, dynamic> json) =>
     _$BlockOrUnblockAgencyRequestFromJson(json);

 Map<String, dynamic> toJson() => _$BlockOrUnblockAgencyRequestToJson(this);
}