import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
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
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/artist_profile_repository/artist_profile_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class ArtistProfileRepositoryImpl implements ArtistProfileRepository {
  final NetworkService networkService;
  final Logger _logger = Logger("ArtistProfileRepository");
  ArtistProfileRepositoryImpl({@required this.networkService})
      : assert(networkService != null);

  @override
  Stream<Resource<ArtistProfileResponse>> fetchArtistProfile(
      ArtistProfileRequest artistProfileRequest) async* {
    assert(artistProfileRequest != null);
    _logger.info('inside fetchArtistProfile');
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .fetchArtistProfile(artistProfileRequest: artistProfileRequest);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> updateArtistProfile(
      ArtistProfileResponse artistProfileResponse) async* {
    assert(artistProfileResponse != null);
    _logger.info('inside updateArtistProfile');
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .updateArtistProfile(artistProfileResponse: artistProfileResponse);
  }

  @override
  Stream<Resource<ExpOrProResponse>> fetchArtistExp(
      ExpOrCred artistExpOrCred) async* {
    assert(artistExpOrCred != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .fetchArtistExperience(artistExpOrCred: artistExpOrCred);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> updateArtistExperience(
      ArtistExperienceModel artistExperienceModel) async* {
    assert(artistExperienceModel != null);
    _logger.info('inside updateArtistExperienceModel:$artistExperienceModel');
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .updateArtistExperience(artistExperienceModel: artistExperienceModel);
  }

  @override
  Stream<Resource<CredResponse>> fetchArtistCredit(
      ExpOrCred artistExpOrCred) async* {
    assert(artistExpOrCred != null);
    _logger
        .info('inside fetchArtistExpOrCred{artistExpOrCred:$artistExpOrCred}');
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .fetchArtistCredits(artistExpOrCred: artistExpOrCred);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> updateArtistCredit(
      CreditModel artistCreditModel) async* {
    assert(artistCreditModel != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .updateArtistCredit(artistCreditModel: artistCreditModel);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> subscribeArtist(
      SubscribeRequest subscribeRequest) async* {
    assert(subscribeRequest != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .subscribeArtist(subscribeRequest: subscribeRequest);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> updateProfilePic(
      UploadProfilePicRequest uploadProfilePicRequest) async* {
    assert(uploadProfilePicRequest != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .uploadProfilePic(uploadProfilePicRequest: uploadProfilePicRequest);
  }

  @override
  Stream<Resource<ArtistAllVideoResponse>> fetchArtistVideos(
      ArtistVideoRequest artistVideoRequest) async* {
    assert(artistVideoRequest != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .fetchArtistVideos(artistVideoRequest: artistVideoRequest);
  }

  @override
  Stream<Resource<NoOfSubscriberResponse>> fetchNoOfSubscribers(String followingId) async* {
    assert(followingId != null);
    yield Resource.loading();
    yield await networkService.artistProfileApi
        .fetchNoOfSubscribers(followingId: followingId);
  }
}
