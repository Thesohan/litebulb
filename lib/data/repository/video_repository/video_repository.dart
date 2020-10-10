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
import 'package:new_artist_project/data/resource.dart';

abstract class VideoRepository{
  Stream<Resource<SimpleMessageResponse>> uploadVideo(UploadVideoRequest uploadVideoRequest);
Stream<Resource<SimpleMessageResponse>> updateLikeVideoStatus(LikeVideoRequest likeVideoRequest);
Stream<Resource<CommentResponse>>  fetchComments(CommentRequest commentRequest);
Stream<Resource<CommentModel>> addComment(AddCommentModel addCommentModel);
Stream<Resource<AgencyProfileResponse>> fetchCommenterAgencyProfile(CommenterProfileRequest commentProfileRequest);
Stream<Resource<ArtistProfileResponse>> fetchCommenterArtistProfile(CommenterProfileRequest commentProfileRequest);

 }