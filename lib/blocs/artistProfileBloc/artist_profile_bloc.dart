import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/request/artist_exp_or_cred_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_video_request.dart';
import 'package:new_artist_project/data/models/api/request/subscribe_request.dart';
import 'package:new_artist_project/data/models/api/request/upload_profle_pic_request.dart';
import 'package:new_artist_project/data/models/api/response/artist_all_video_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/no_of_subscriber_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/artist_profile_repository/artist_profile_repository.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/util/id_name_converter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:shared_preferences/shared_preferences.dart';

class ArtistProfileBloc extends BaseBloc<FetchArtistProfileDataEvent> {
  ArtistProfileBloc({ArtistProfileRepository artistProfileRepository})
      : _artistProfileRepository = artistProfileRepository ??
            kiwi.Container().resolve<ArtistProfileRepository>() {
    init();
  }
  final Logger _logger = Logger('ArtistProfileBloc');
  final ArtistProfileRepository _artistProfileRepository;

  ///  for Artist bio
  final BehaviorSubject<Resource<ArtistProfileResponse>>
      _artistBioResponsePublishSubject =
      BehaviorSubject<Resource<ArtistProfileResponse>>();
  Observable<Resource<ArtistProfileResponse>> get artistBioResponseObservable =>
      _artistBioResponsePublishSubject.stream;

  /// for artist experience
  final PublishSubject<Resource<ExpOrProResponse>>
      _artistExperiencesPublishSubject =
      PublishSubject<Resource<ExpOrProResponse>>();
  Observable<Resource<ExpOrProResponse>> get artistExperienceObservable =>
      _artistExperiencesPublishSubject.stream;

  /// for artist credits;
  final PublishSubject<Resource<CredResponse>>
      _artistCreditResponsePublishSubject =
      PublishSubject<Resource<CredResponse>>();
  Observable<Resource<CredResponse>> get artistCredResponseObservable =>
      _artistCreditResponsePublishSubject.stream;

  /// show all or show less value handler.
  final PublishSubject<bool> _isShowAllPressedPublishSubject =
      PublishSubject<bool>();
  Observable<bool> get isShowAllPressedObservable =>
      _isShowAllPressedPublishSubject.stream;

  /// artist videos
  final PublishSubject<Resource<ArtistAllVideoResponse>>
      _artistVideosPublishSubject =
      PublishSubject<Resource<ArtistAllVideoResponse>>();
  Observable<Resource<ArtistAllVideoResponse>> get artistVideosObservable =>
      _artistVideosPublishSubject.stream;

  /// no of subscribers;
  final BehaviorSubject<Resource<NoOfSubscriberResponse>>
      _noOfSubscribersPublishSubject =
      BehaviorSubject<Resource<NoOfSubscriberResponse>>();
  Observable<Resource<NoOfSubscriberResponse>> get noOfSubscribersObservable => _noOfSubscribersPublishSubject.stream;


  @override
  void handleEvent(FetchArtistProfileDataEvent event) {
    if (event is FetchArtistBioEvent) {
      _fetchProfileData();
    } else if (event is FetchArtistExpOrCredEvent) {
      _fetchArtistExpOrCred(event);
    } else if (event is UpdateShowAllPressStatus) {
      _updateShowAllPressedStatus(event);
    } else if (event is UpdateProfileEvent) {
      _updateProfile(event);
    } else if (event is FetchOtherArtistExpOrCredEvent) {
      _fetchOtherArtistExpOrCred(event);
    } else if (event is SubscriptionEvent) {
      _subscribeArtist(event);
    } else if (event is FetchArtistCreditsFromPref) {
      _fetchArtistCredits();
    } else if (event is FetchArtistExperienceFromPref) {
      _fetchArtistExperiences();
    } else if (event is FetchArtistVideoEvent) {
      _fetchArtistVideos(event);
    } else if (event is FetchNoOfSubscriberEvent) {
      _fetchNoOfSubscriber(event);
    }
  }

  @override
  void dispose() {
    _artistBioResponsePublishSubject.close();
    _artistExperiencesPublishSubject.close();
    _artistCreditResponsePublishSubject.close();
    _isShowAllPressedPublishSubject.close();
    _artistVideosPublishSubject.close();
    _noOfSubscribersPublishSubject.close();
    super.dispose();
  }

  Future<List<CategoryModel>> _getCategoryList() async {
    List<CategoryModel> categoryList = [];
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    categoryList = await sharedPrefHandler.getCategoryList();
    return categoryList;
  }

  void _fetchProfileData() async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    IdNameConverter categoryConverter =
        IdNameConverter(categoryList: await _getCategoryList());
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      ArtistProfileRequest artistProfileRequest = ArtistProfileRequest(
        id: artistProfileResponse.id,
        email: artistProfileResponse.email,
      );
      Resource<ArtistProfileResponse> res = await _artistProfileRepository
          .fetchArtistProfile(artistProfileRequest)
          .last;

      res = res.copyWithNewData(
        data: res.data?.copyWith(
          is_subscribed: '0',
          is_addedtowishlist: '0',
          category: categoryConverter.getCategoryNameFromId(
              categoryId: res.data?.category),
        ),
      );
      sharedPrefHandler.setArtistBio(res.data);
      _artistBioResponsePublishSubject.add(res);
    }
  }

  void _fetchArtistExpOrCred(FetchArtistExpOrCredEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      ExpOrCred artistExpOrCred =
          ExpOrCred(value: event.value, id: artistProfileResponse.id);

      if (event.value == 'experience') {
        Resource<ExpOrProResponse> artistExpResponseResource =
            await _artistProfileRepository.fetchArtistExp(artistExpOrCred).last;
        if (artistExpResponseResource?.data?.data != null) {
          await sharedPrefHandler
              .setArtistExperience(artistExpResponseResource.data);
          _artistExperiencesPublishSubject.add(artistExpResponseResource);
        }
      } else if (artistExpOrCred.value == 'credits') {
        Resource<CredResponse> artistCredResponseResource =
            await _artistProfileRepository
                .fetchArtistCredit(artistExpOrCred)
                .last;
        if (artistCredResponseResource?.data?.data != null) {
          await sharedPrefHandler
              .setArtistCredits(artistCredResponseResource.data);
          _artistCreditResponsePublishSubject.add(artistCredResponseResource);
        }
      }
    }
  }

  void _fetchArtistCredits() async {
    CredResponse artistCredResponse = await _getArtistCredResponse();
    if (artistCredResponse != null) {
      Resource<CredResponse> res = Resource.success(
        data: artistCredResponse,
        message: "success",
      );
      _artistCreditResponsePublishSubject.add(res);
    }
  }

  void _fetchArtistExperiences() async {
    ExpOrProResponse artistExpResponse = await _getArtistExpResponse();
    if (artistExpResponse != null) {
      Resource<ExpOrProResponse> res = Resource.success(
        data: artistExpResponse,
        message: "success",
      );
      _artistExperiencesPublishSubject.add(res);
    }
  }

  Future<CredResponse> _getArtistCredResponse(
      {bool isOtherArtist = false}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String jsonString = _sharedPreferences.get(isOtherArtist
        ? SharedPrefHandler.OTHER_ARTIST_CREDIT_CACHE_KEY
        : SharedPrefHandler.ARTIST_CREDIT_CACHE_KEY);
    if (jsonString != null) {
      Map<String, dynamic> artistCreditResponse = json.decode(
        jsonString,
      );
      if (artistCreditResponse != null) {
        CredResponse artistCredResponse =
            CredResponse.fromJson(artistCreditResponse);
        return artistCredResponse;
      }
    }
    return null;
  }

  Future<ExpOrProResponse> _getArtistExpResponse(
      {bool isOtherArtist = false}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String jsonString = _sharedPreferences.get(isOtherArtist
        ? SharedPrefHandler.OTHER_ARTIST_EXPERIENCE_CACHE_KEY
        : SharedPrefHandler.ARTIST_EXPERIENCE_CACHE_KEY);
    if (jsonString != null) {
      Map<String, dynamic> artistExperienceResponse = json.decode(jsonString);
      if (artistExperienceResponse != null) {
        ExpOrProResponse artistExpOrCredResponse =
            ExpOrProResponse.fromJson(artistExperienceResponse);
        return artistExpOrCredResponse;
      }
    }
    return null;
  }

  void _updateShowAllPressedStatus(UpdateShowAllPressStatus event) async {
    _isShowAllPressedPublishSubject.add(event.isShowAllPressed);

    /// for updating artist experience data
    if (event.isExperience) {
      ExpOrProResponse artistExpOrCredResponse =
          await _getArtistExpResponse(isOtherArtist: event.isOtherArtist);
      if (!event.isShowAllPressed) {
        if (artistExpOrCredResponse != null &&
            artistExpOrCredResponse.data.length > 0) {
          ExpOrProResponse showLessArtistExp = ExpOrProResponse(
            data: [artistExpOrCredResponse.data[0]],
            success: artistExpOrCredResponse.success,
            message: artistExpOrCredResponse.message,
          );
          Resource<ExpOrProResponse> res = Resource(
              message: artistExpOrCredResponse.message,
              data: showLessArtistExp,
              status: Status.success);
          _logger.info('res :${res.data.data}');
          _artistExperiencesPublishSubject.add(res);
        }
      } else {
        Resource<ExpOrProResponse> res = Resource(
            message: artistExpOrCredResponse.message,
            data: artistExpOrCredResponse,
            status: Status.success);
        _logger.info('res :${res.data.data}');
        _artistExperiencesPublishSubject.add(res);
      }
    }

    /// for updating artist credit data
    else {
      CredResponse artistCreditResponse =
          await _getArtistCredResponse(isOtherArtist: event.isOtherArtist);
      if (!event.isShowAllPressed) {
        if (artistCreditResponse != null &&
            artistCreditResponse.data.length > 0) {
          CredResponse showLessArtistCred = CredResponse(
            data: [artistCreditResponse.data[0]],
            success: artistCreditResponse.success,
            message: artistCreditResponse.message,
          );
          Resource<CredResponse> res = Resource(
            message: artistCreditResponse.message,
            data: showLessArtistCred,
            status: Status.success,
          );
          _artistCreditResponsePublishSubject.add(res);
        }
      } else {
        Resource<CredResponse> res = Resource(
            message: artistCreditResponse.message,
            data: artistCreditResponse,
            status: Status.success);
        _artistCreditResponsePublishSubject.add(res);
      }
    }
  }

  void _updateProfile(UpdateProfileEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();

    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      UploadProfilePicRequest uploadProfilePicRequest =
          UploadProfilePicRequest().copyWith(
              thumbnail: event.thumbnail,
              artistProfileResponse: artistProfileResponse);
      Resource<SimpleMessageResponse> res = await _artistProfileRepository
          .updateProfilePic(uploadProfilePicRequest)
          .last;
      event.completer.complete(res.data);
    }
  }

  void _fetchOtherArtistExpOrCred(FetchOtherArtistExpOrCredEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();

    ExpOrCred artistExpOrCred = ExpOrCred(
      value: event.value,
      id: event.id,
    );
    if (event.value == 'experience') {
      Resource<ExpOrProResponse> artistExpResponseResource =
          await _artistProfileRepository.fetchArtistExp(artistExpOrCred).last;
      await sharedPrefHandler
          .setOtherArtistExperience(artistExpResponseResource.data);
      _artistExperiencesPublishSubject.add(artistExpResponseResource);
    } else if (artistExpOrCred.value == 'credits') {
      Resource<CredResponse> artistCredResponseResource =
          await _artistProfileRepository
              .fetchArtistCredit(artistExpOrCred)
              .last;
      await sharedPrefHandler
          .setOtherArtistCredits(artistCredResponseResource.data);

      _artistCreditResponsePublishSubject.add(artistCredResponseResource);
    }
  }

  void _subscribeArtist(SubscriptionEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      SubscribeRequest subscribeRequest = SubscribeRequest(
        follower_id: artistProfileResponse.id,
        following_id: event.followingId,
      );
      _logger.info("follower_id:${subscribeRequest.follower_id}, following_id:${subscribeRequest.following_id}");
      Resource<SimpleMessageResponse> res =
          await _artistProfileRepository.subscribeArtist(subscribeRequest).last;
      if (res != null && res.data != null) {
        Resource<NoOfSubscriberResponse> noOfSubscriberRes=await _noOfSubscribersPublishSubject.first;
       int noOfSubscriber = noOfSubscriberRes.data.data;
       if(res.data.message=='Subscribed'){
         noOfSubscriberRes= noOfSubscriberRes.copyWithNewData(data: NoOfSubscriberResponse(data: noOfSubscriber+1));
       }
       else if(res.data.message=='You unsubscribed'){
         noOfSubscriberRes= noOfSubscriberRes.copyWithNewData(data: NoOfSubscriberResponse(data: noOfSubscriber-1));
       }
       _noOfSubscribersPublishSubject.add(noOfSubscriberRes);
       event.completer.complete(res.data.message);
      }
    }
  }

  void getLoggedInArtistProfile() async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      Resource<ArtistProfileResponse> res =
          Resource.success(data: artistProfileResponse);
      _artistBioResponsePublishSubject.add(res);
    }
  }

  void init() {}

  void _fetchArtistVideos(FetchArtistVideoEvent event) async {
    _artistVideosPublishSubject.add(null);
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    ArtistVideoRequest artistVideoRequest = ArtistVideoRequest(
      artistid: event.artistId ?? artistProfileResponse.id,
      videoid: "All",
      userid: artistProfileResponse.id,
    );
    Resource<ArtistAllVideoResponse> res = await _artistProfileRepository
        .fetchArtistVideos(artistVideoRequest)
        .last;
    if (res != null && res.data != null) {
      _artistVideosPublishSubject.add(res);
    }
  }

  void _fetchNoOfSubscriber(FetchNoOfSubscriberEvent event) async {
    String followingId = event.followingId;
    if (followingId == null) {
      SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
      ArtistProfileResponse artistProfileResponse =
          await sharedPrefHandler.getArtistBio();
      followingId = artistProfileResponse.id;
    }
    Resource<NoOfSubscriberResponse> res =
        await _artistProfileRepository.fetchNoOfSubscribers(followingId).last;
    if (res != null && res.data != null) {
      _noOfSubscribersPublishSubject.add(res);
    }
  }
}
