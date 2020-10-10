import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/data/models/api/add_comment_model.dart';
import 'package:new_artist_project/data/models/api/comment_model.dart';
import 'package:new_artist_project/data/models/api/request/comment_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/request/like_video_request.dart';
import 'package:new_artist_project/data/models/api/request/upload_video_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/comment_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/video_repository/video_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class VideoRepositoryImpl extends VideoRepository{
  final NetworkService networkService;

  VideoRepositoryImpl({@required this.networkService}):assert(networkService!=null);
  @override
  Stream<Resource<SimpleMessageResponse>> uploadVideo(UploadVideoRequest uploadVideoRequest) async*{
    assert(uploadVideoRequest!=null);
    yield Resource.loading();
    yield await  networkService.videoApi.uploadVideoDetails(uploadVideoRequest: uploadVideoRequest);
  }

  @override
  Stream<Resource<SimpleMessageResponse>> updateLikeVideoStatus(LikeVideoRequest likeVideoRequest) async*{
    assert(likeVideoRequest!=null);
    yield Resource.loading();
    yield await networkService.videoApi.updateLikeVideoStatus(likeVideoRequest: likeVideoRequest);
  }

  @override
  Stream<Resource<CommentResponse>> fetchComments(CommentRequest commentRequest)async* {
    assert(commentRequest!=null);
    yield Resource.loading();
    yield await networkService.videoApi.fetchComment(commentRequest: commentRequest);
  }

  @override
  Stream<Resource<CommentModel>> addComment(AddCommentModel addCommentModel) async*{
   assert(addCommentModel!=null);
   yield Resource.loading();
   yield await networkService.videoApi.addComments(addCommentModel: addCommentModel);
  }

  @override
  Stream<Resource<AgencyProfileResponse>> fetchCommenterAgencyProfile(CommenterProfileRequest commenterProfileRequest)async* {
    assert(commenterProfileRequest!=null);
    yield Resource.loading();
    yield await networkService.videoApi.fetchCommenterAgencyProfile(commenterProfileRequest: commenterProfileRequest);
  }

  @override
  Stream<Resource<ArtistProfileResponse>> fetchCommenterArtistProfile(CommenterProfileRequest commenterProfileRequest) async*{
    assert(commenterProfileRequest!=null);
    yield Resource.loading();
    yield await networkService.videoApi.fetchCommenterArtistProfile(commenterProfileRequest: commenterProfileRequest);
  }

}