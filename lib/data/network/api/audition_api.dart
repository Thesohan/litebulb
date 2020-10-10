import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/data/models/api/request/add_to_wishlist_request.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/applied_audition_by_artist_request.dart';
import 'package:new_artist_project/data/models/api/request/apply_audition_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/models/api/response/applied_audition_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class AuditionApi {
  final RequestHandler _requestHandler;

  AuditionApi(this._requestHandler);

  Future<Resource<AuditionListResponse>> fetchFeaturedAudition(
      AuditionRequest auditionRequest) async {
    assert(auditionRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: auditionRequest.toJson(),
      path: "/Auditionlist_controller/index_post",
      responseMapper: (data) => AuditionListResponse.fromJson(data.data),
    );
  }

  Future<Resource<AuditionListResponse>> fetchAgencyAudition(
      AuditionRequest auditionRequest) async {
    assert(auditionRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: "/Auditionlist_controller/index_post",
      body: auditionRequest.toJson(),
      responseMapper: (data) => AuditionListResponse.fromJson(data.data),
    );
  }

  Future<Resource<SimpleMessageResponse>> applyAudition(
      ApplyAuditionRequest applyAuditionRequest) async {
    assert(applyAuditionRequest != null);
    print(applyAuditionRequest.postid);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: "/applied_controller/index_post",
      body: applyAuditionRequest.toJson(),
      responseMapper: (data) => SimpleMessageResponse.fromJson(data.data),
    );
  }

  Future<Resource<SimpleMessageResponse>> addToWishlist(
      AddToWishlistRequest addToWishlistRequest) async {
    assert(addToWishlistRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: "/wishlist_controller/index_post",
      body: addToWishlistRequest.toJson(),
      responseMapper: (data) => SimpleMessageResponse.fromJson(data.data),
    );
  }

  Future<Resource<AppliedAuditionResponse>> fetchAppliedAuditionByArtist(
      AppliedAuditionByArtistRequest appliedAuditionByArtistRequest) async {
    assert(appliedAuditionByArtistRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: '/history_controller/index_post',
      body: appliedAuditionByArtistRequest.toJson(),
      responseMapper: (data) => AppliedAuditionResponse.fromJson(data.data),
    );
  }

  Future<Resource<ArtistWishlistResponse>> fetchWishlistResponse({
    @required ArtistIdRequest artistWishlistRequest,
  }) async {
    assert(artistWishlistRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: artistWishlistRequest.toJson(),
      path: "/FetchWishlist_controller/index_post",
      responseMapper: (data) => ArtistWishlistResponse.fromJson(data.data),
    );
  }


  Future<Resource<AgencyProfileResponse>> fetchAgencyProfileResponse({
    @required AgencyProfileRequest agencyProfileRequest,
  }) async {
    assert(agencyProfileRequest!= null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: agencyProfileRequest.toJson(),
      path: "/AgencyProfile_controller/index_post/",
      responseMapper: (data) => AgencyProfileResponse.fromJson(data.data),
    );
  }
}
