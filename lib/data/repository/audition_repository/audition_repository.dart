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
import 'package:new_artist_project/data/resource.dart';

abstract class AuditionRepository {
  Stream<Resource<AuditionListResponse>> fetchFeaturedAudition(
      AuditionRequest auditionRequest);
  Stream<Resource<AuditionListResponse>> fetchAgencyAudition(
      AuditionRequest auditionRequest);

  Stream<Resource<SimpleMessageResponse>> applyAudition(
      ApplyAuditionRequest auditionRequest);
  Stream<Resource<SimpleMessageResponse>> addToWishlist(
      AddToWishlistRequest addToWishlistRequest);

  Stream<Resource<AppliedAuditionResponse>> fetchAppliedAudition(
      AppliedAuditionByArtistRequest appliedAuditionByArtistRequest);

  Stream<Resource<ArtistWishlistResponse>> fetchWishlist(
      ArtistIdRequest artistWishlistRequest);


  Stream<Resource<AgencyProfileResponse>> fetchAgencyProfile(
      AgencyProfileRequest agencyProfileRequest);
}
