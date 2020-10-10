import 'package:new_artist_project/data/models/api/request/add_to_wishlist_request.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/applied_audition_by_artist_request.dart';
import 'package:new_artist_project/data/models/api/request/apply_audition_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/applied_audition_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/audition_repository/audition_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class AuditionRepositoryImpl implements AuditionRepository {
  final NetworkService networkService;

  AuditionRepositoryImpl(this.networkService);
  @override
  Stream<Resource<AuditionListResponse>> fetchFeaturedAudition(
      AuditionRequest auditionRequest) async* {
    assert(auditionRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi
        .fetchFeaturedAudition(auditionRequest);
  }

  @override
  Stream<Resource<AuditionListResponse>> fetchAgencyAudition(
      AuditionRequest auditionRequest) async* {
    assert(auditionRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi.fetchAgencyAudition(auditionRequest);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> applyAudition(
      ApplyAuditionRequest auditionRequest) async* {
    assert(auditionRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi.applyAudition(auditionRequest);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> addToWishlist(
      AddToWishlistRequest addToWishlistRequest) async* {
    assert(addToWishlistRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi.addToWishlist(addToWishlistRequest);
  }

  @override
  Stream<Resource<AppliedAuditionResponse>> fetchAppliedAudition(
      AppliedAuditionByArtistRequest appliedAuditionByArtistRequest) async* {
    assert(appliedAuditionByArtistRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi
        .fetchAppliedAuditionByArtist(appliedAuditionByArtistRequest);
  }

  @override
  Stream<Resource<ArtistWishlistResponse>> fetchWishlist(
      ArtistIdRequest artistWishlistRequest) async* {
    assert(artistWishlistRequest != null);
    yield Resource.loading();
    yield await networkService.auditionApi
        .fetchWishlistResponse(artistWishlistRequest: artistWishlistRequest);
  }

  @override
  Stream<Resource<AgencyProfileResponse>> fetchAgencyProfile(AgencyProfileRequest agencyProfileRequest) async*{
   assert(agencyProfileRequest!=null);
   yield Resource.loading();
   yield await networkService.auditionApi.fetchAgencyProfileResponse(agencyProfileRequest: agencyProfileRequest);
  }
}
