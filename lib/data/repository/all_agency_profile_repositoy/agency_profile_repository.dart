import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_exp_or_cred_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/block_or_unblock_agency_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/blocked_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/resource.dart';

abstract class AgencyProfileRepository {
  Stream<Resource<AllAgencyProfileResponse>> fetchAgencyProfile(
      {@required AgencyProfileRequest agencyProfileRequest});
  Stream<Resource<CredResponse>> fetchAgencyCredit(
      {@required ExpOrCred agencyCredRequest});
  Stream<Resource<ExpOrProResponse>> fetchAgencyProject(
      {@required ExpOrCred agencyCredRequest});
  Stream<Resource<BlockedAgencyProfileResponse>> fetchBlockedAgencies(
      {@required ArtistIdRequest artistIdRequest});
  Stream<Resource<SimpleMessageResponse>>blockOrUnblockAgency(BlockOrUnblockAgencyRequest blockOrUnblockAgencyRequest);
}
