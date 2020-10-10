import 'package:flutter/widgets.dart';
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
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/all_agency_profile_repositoy/agency_profile_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class AgencyProfileRepositoryImpl implements AgencyProfileRepository {
  final NetworkService networkService;
  AgencyProfileRepositoryImpl({@required this.networkService})
      : assert(networkService != null);

  @override
  Stream<Resource<AllAgencyProfileResponse>> fetchAgencyProfile(
      {AgencyProfileRequest agencyProfileRequest}) async* {
    assert(agencyProfileRequest != null);
    yield Resource.loading();
    yield await networkService.allAgencyProfileApi
        .fetchAllAgencyInfo(agencyProfileRequest: agencyProfileRequest);
  }

  @override
  Stream<Resource<CredResponse>> fetchAgencyCredit(
      {ExpOrCred agencyCredRequest}) async* {
    assert(agencyCredRequest != null);
    yield Resource.loading();
    yield await networkService.allAgencyProfileApi
        .fetchAgencyCredit(artistExpOrCred: agencyCredRequest);
  }


  @override
  Stream<Resource<BlockedAgencyProfileResponse>> fetchBlockedAgencies({ArtistIdRequest artistIdRequest}) async*{
   assert(artistIdRequest!=null);
   yield Resource.loading();
   yield await networkService.allAgencyProfileApi.fetchBlockedAgencies(artistIdRequest: artistIdRequest);
  }


  @override
  Stream<Resource<ExpOrProResponse>> fetchAgencyProject(
      {ExpOrCred agencyCredRequest}) async* {
    assert(agencyCredRequest != null);
    yield Resource.loading();
    yield await networkService.allAgencyProfileApi.fetchAgencyProjects(
      expOrCred: ExpOrCred(
        value: agencyCredRequest.value,
        id: agencyCredRequest.id,
      ),
    );
  }

  @override
  Stream<Resource<SimpleMessageResponse>> blockOrUnblockAgency(BlockOrUnblockAgencyRequest blockOrUnblockAgencyRequest) async*{
    assert(blockOrUnblockAgencyRequest!=null);
    yield Resource.loading();
    yield await networkService.allAgencyProfileApi.blockOrUnblockAgency(blockOrUnblockAgencyRequest: blockOrUnblockAgencyRequest);
  }
}
