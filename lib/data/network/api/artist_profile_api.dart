import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/api/response/no_of_subscriber_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class ArtistProfileApi {
  final RequestHandler _requestHandler;
  final Logger _logger = Logger('ArtistProfileApi');
  ArtistProfileApi(this._requestHandler) : assert(_requestHandler != null);

  Future<Resource<ArtistProfileResponse>> fetchArtistProfile({
    @required ArtistProfileRequest artistProfileRequest,
  }) async {
    assert(artistProfileRequest != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        path: '/Myprofile_controller/index_post',
        body: artistProfileRequest.toJson(),
        responseMapper: (data) {
          _logger.info('response: $data');
          return ArtistProfileResponse.fromJson(data.data['data'][0]);
        });
  }

  Future<Resource<SimpleMessageResponse>> updateArtistProfile(
      {@required ArtistProfileResponse artistProfileResponse}) async {
    assert(artistProfileResponse != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        path: "/EditArtistProfile_controller/index_post",
        body: artistProfileResponse.toJson(),
        responseMapper: (data) {
          return SimpleMessageResponse.fromJson(data.data);
        });
  }

  Future<Resource<ExpOrProResponse>> fetchArtistExperience(
      {@required ExpOrCred artistExpOrCred}) async {
    assert(artistExpOrCred != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: "/FetchExp_controller/index_post",
      body: artistExpOrCred.toJson(),
      responseMapper: (data) => ExpOrProResponse.fromJson(data.data),
    );
  }

  Future<Resource<CredResponse>> fetchArtistCredits(
      {@required ExpOrCred artistExpOrCred}) async {
    assert(artistExpOrCred != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      path: "/FetchExp_controller/index_post",
      body: artistExpOrCred.toJson(),
      responseMapper: (data) => CredResponse.fromJson(data.data),
    );
  }

  Future<Resource<SimpleMessageResponse>> updateArtistExperience(
      {@required ArtistExperienceModel artistExperienceModel}) async {
    assert(artistExperienceModel != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: artistExperienceModel.toJson(),
      path: "/Exp_controller/index_post",
      responseMapper: (data) => SimpleMessageResponse.fromJson(data.data),
    );
  }

  Future<Resource<SimpleMessageResponse>> updateArtistCredit(
      {@required CreditModel artistCreditModel}) async {
    assert(artistCreditModel != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: artistCreditModel.toJson(),
      path: "/Credit_controller/index_post",
      responseMapper: (data) => SimpleMessageResponse.fromJson(data.data),
    );
  }

  Future<Resource<SimpleMessageResponse>> subscribeArtist(
      {@required SubscribeRequest subscribeRequest}) async {
    assert(subscribeRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: subscribeRequest.toJson(),
      path: "/Sub_controller/index_post",
      responseMapper: (data) {
       return SimpleMessageResponse.fromJson(data.data);
      }
    );
  }

  Future<Resource<SimpleMessageResponse>> uploadProfilePic(
      {@required UploadProfilePicRequest uploadProfilePicRequest}) async {
    assert(uploadProfilePicRequest != null);
    FormData formData = FormData.fromMap({
      'thumbnail': uploadProfilePicRequest.thumbnail != null
          ? await MultipartFile.fromFile(
        uploadProfilePicRequest.thumbnail.path,
        filename: uploadProfilePicRequest.thumbnail.path.split('/').last,
      )
          : null,
      'username': uploadProfilePicRequest.username,
      'id':uploadProfilePicRequest.id,
      'name':uploadProfilePicRequest.name,
      'local':uploadProfilePicRequest.local,
      'gender':uploadProfilePicRequest.gender,
      'avatar':uploadProfilePicRequest.avatar,
      'birthday':uploadProfilePicRequest.birthday,
      'glink':uploadProfilePicRequest.glink,
      'contact':uploadProfilePicRequest.contact,
      'about':uploadProfilePicRequest.about,
      'category':uploadProfilePicRequest.category,
      'fblink':uploadProfilePicRequest.fblink,
      'twlink':uploadProfilePicRequest.twlink,
      'iglink':uploadProfilePicRequest.iglink,
      'skills':uploadProfilePicRequest.skills,
      'language':uploadProfilePicRequest.language,
      'age':uploadProfilePicRequest.age,
      'lastNoty':uploadProfilePicRequest.lastNoty,
      'skintone':uploadProfilePicRequest.skintone,
      'hips':uploadProfilePicRequest.hips,
      'height':uploadProfilePicRequest.height,
      'bustchest':uploadProfilePicRequest.butchest,
      'waist':uploadProfilePicRequest.waist,
    });


    return _requestHandler.sendRequest(
      method: Method.post,
      body: formData,
      path: "/EditArtistProfile_controller/index_post",
      responseMapper: (data) => SimpleMessageResponse.fromJson(data.data),
    );
  }


  Future<Resource<ArtistAllVideoResponse>> fetchArtistVideos(
      {@required ArtistVideoRequest artistVideoRequest}) async {
    assert(artistVideoRequest!= null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: artistVideoRequest.toJson(),
      path: "/artistvideos_controller/index_post",
      responseMapper: (data) => ArtistAllVideoResponse.fromJson(data.data),
    );
  }


  Future<Resource<NoOfSubscriberResponse>> fetchNoOfSubscribers(
      {@required String followingId}) async {
    assert(followingId!= null);
    Map<String,dynamic>requestObj = {
      'following_id':followingId
    };
    return _requestHandler.sendRequest(
      method: Method.post,
      body: requestObj,
      path: "/GetSub_controller/index_post/",
      responseMapper: (data) => NoOfSubscriberResponse.fromJson(data.data),
    );
  }
}
