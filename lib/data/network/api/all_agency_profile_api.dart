import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_exp_or_cred_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/block_or_unblock_agency_request.dart';
import 'package:new_artist_project/data/models/api/response/all_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/blocked_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class AllAgencyProfileApi {
  final RequestHandler _requestHandler;
  final Logger _logger = Logger('AllArtistInfoApi');

  AllAgencyProfileApi(this._requestHandler) : assert(_requestHandler != null);

  Future<Resource<AllAgencyProfileResponse>>  fetchAllAgencyInfo({
    @required AgencyProfileRequest agencyProfileRequest,
  }) async {
    assert(agencyProfileRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: agencyProfileRequest.toJson(),
      path: "/FetchAgency_controller/index_post",
      responseMapper: (data) => AllAgencyProfileResponse.fromJson(data.data),
    );
  }

  Future<Resource<CredResponse>> fetchAgencyCredit(
      {@required ExpOrCred artistExpOrCred}) async {
    assert(artistExpOrCred != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: artistExpOrCred.toJson(),
        path: "/FetchAgencyPro_controller/index_post",
        responseMapper: (data) => CredResponse.fromJson(data.data));
  }

  Future<Resource<ExpOrProResponse>> fetchAgencyProjects(
      {@required ExpOrCred expOrCred}) async {
    assert(expOrCred != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: expOrCred.toJson(),
        path: "/FetchAgencyPro_controller/index_post",
        responseMapper: (data) => ExpOrProResponse.fromJson(data.data));
  }

  Future<Resource<BlockedAgencyProfileResponse>> fetchBlockedAgencies(
      {@required ArtistIdRequest artistIdRequest}) async {
    assert(artistIdRequest!= null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: artistIdRequest.toJson(),
        path: "/FetchArtistBlock_controller/index_post",
        responseMapper: (data) => BlockedAgencyProfileResponse.fromJson(data.data));
  }


  Future<Resource<SimpleMessageResponse>> blockOrUnblockAgency(
      {@required BlockOrUnblockAgencyRequest blockOrUnblockAgencyRequest}) async {
    assert(blockOrUnblockAgencyRequest!= null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: blockOrUnblockAgencyRequest.toJson(),
        path: "/Block_controller/index_post",
        responseMapper: (data) => SimpleMessageResponse.fromJson(data.data));
  }
}
