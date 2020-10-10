import 'package:new_artist_project/data/models/api/request/artist_exp_or_cred_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_video_request.dart';
import 'package:new_artist_project/data/models/api/request/subscribe_request.dart';
import 'package:new_artist_project/data/models/api/request/upload_profle_pic_request.dart';
import 'package:new_artist_project/data/models/api/response/artist_all_video_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/no_of_subscriber_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/data/resource.dart';

abstract class ArtistProfileRepository {
  Stream<Resource<ArtistProfileResponse>> fetchArtistProfile(
      ArtistProfileRequest artistProfileRequest);
  Stream<Resource<SimpleMessageResponse>> updateArtistProfile(
      ArtistProfileResponse artistProfileResponse);
  Stream<Resource<ExpOrProResponse>> fetchArtistExp(ExpOrCred artistExpOrCred);
  Stream<Resource<SimpleMessageResponse>> updateArtistExperience(
      ArtistExperienceModel artistExperienceModel);
  Stream<Resource<CredResponse>> fetchArtistCredit(ExpOrCred artistExpOrCred);
  Stream<Resource<SimpleMessageResponse>> updateArtistCredit(
      CreditModel artistCreditModel);
  Stream<Resource<SimpleMessageResponse>> subscribeArtist(
      SubscribeRequest subscribeRequest);
  Stream<Resource<SimpleMessageResponse>> updateProfilePic(
      UploadProfilePicRequest uploadProfilePicRequest);
  Stream<Resource<ArtistAllVideoResponse>> fetchArtistVideos(ArtistVideoRequest artistVideoRequest);
  Stream<Resource<NoOfSubscriberResponse>> fetchNoOfSubscribers(String followingId);
}
