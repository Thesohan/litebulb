import 'dart:convert';
import 'dart:io';
import 'package:new_artist_project/data/models/api/add_comment_model.dart';
import 'package:new_artist_project/data/models/api/comment_model.dart';
import 'package:new_artist_project/data/models/api/request/comment_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/request/like_video_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/comment_response.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/forgot_password_request.dart';
import 'package:new_artist_project/data/models/api/request/login_model.dart';
import 'package:new_artist_project/data/models/api/request/logout_request.dart';
import 'package:new_artist_project/data/models/api/request/register_artist_request.dart';
import 'package:new_artist_project/data/models/api/request/upload_video_request.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class VideoApi {
  final RequestHandler _requestHandler;
  VideoApi(this._requestHandler);

  Future<Resource<SimpleMessageResponse>> uploadVideoDetails({
    @required UploadVideoRequest uploadVideoRequest,
  }) async {
    assert(uploadVideoRequest != null);
    FormData formData = FormData.fromMap({
      "files": uploadVideoRequest.files != null
          ? await MultipartFile.fromFile(
              uploadVideoRequest.files.path,
              filename: uploadVideoRequest.files.path.split('/').last,
            )
          : null,
      'thumbnail': uploadVideoRequest.thumbnail != null
          ? await MultipartFile.fromFile(
              uploadVideoRequest.thumbnail.path,
              filename: uploadVideoRequest.thumbnail.path.split('/').last,
            )
          : null,
      'title': uploadVideoRequest.title,
      'category': uploadVideoRequest.category,
      'description': uploadVideoRequest.description,
      'tags': uploadVideoRequest.tags,
      'is_safe': uploadVideoRequest.is_safe,
      'is_public': uploadVideoRequest.is_public,
      'id': uploadVideoRequest.id,
      'video_id': uploadVideoRequest.video_id,
    });
    return _requestHandler.sendRequest(
      method: Method.post,
      path: '/upload_controller/index_post/',
      body: formData,
      responseMapper: (data) {
        return SimpleMessageResponse.fromJson(data.data);
      },
    );
  }

  Future<Resource<SimpleMessageResponse>> updateLikeVideoStatus(
      {@required LikeVideoRequest likeVideoRequest}) async {
    assert(likeVideoRequest != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: likeVideoRequest.toJson(),
        path: "/Like_controller/index_post/",
        responseMapper: (data) => SimpleMessageResponse.fromJson(data.data));
  }

  Future<Resource<CommentResponse>> fetchComment(
      {@required CommentRequest commentRequest}) async {
    assert(commentRequest != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: commentRequest.toJson(),
        path: "/comment_controller/index_post/",
        responseMapper: (data) => CommentResponse.fromJson(data.data));
  }


  Future<Resource<CommentModel>> addComments(
      {@required AddCommentModel addCommentModel}) async {
    assert(addCommentModel != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: addCommentModel.toJson(),
        path: "/Comments_controller/index_post/",
        responseMapper: (data) => CommentModel.fromJson(data.data));
  }


  Future<Resource<AgencyProfileResponse>> fetchCommenterAgencyProfile(
      {@required CommenterProfileRequest commenterProfileRequest}) async {
    assert(commenterProfileRequest != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: commenterProfileRequest.toJson(),
        path: "/Findbyid_controller/index_post/",
        responseMapper: (data) => AgencyProfileResponse.fromJson(data.data));
  }


  Future<Resource<ArtistProfileResponse>> fetchCommenterArtistProfile(
      {@required CommenterProfileRequest commenterProfileRequest}) async {
    assert(commenterProfileRequest != null);
    return _requestHandler.sendRequest(
        method: Method.post,
        body: commenterProfileRequest.toJson(),
        path: "/Findbyid_controller/index_post/",
        responseMapper: (data) => ArtistProfileResponse.fromJson(data.data['data'][0]));
  }
}
