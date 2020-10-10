import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
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
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/video_repository/video_repository.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/util/id_name_converter.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc extends BaseBloc<VideoEvent> {
  VideoBloc({VideoRepository videoRepository})
      : _videoRepository =
            videoRepository ?? kiwi.Container().resolve<VideoRepository>() {
    _init();
  }
  Logger _logger = Logger("VideoBloc");
  VideoRepository _videoRepository;

  Set<String> _tags = Set();
  BehaviorSubject<Set<String>> _tagBehaviourSubject =
      BehaviorSubject<Set<String>>();

  Observable<Set<String>> get tagObservable => _tagBehaviourSubject.stream;

  BehaviorSubject<File> _videoFileBehaviourSubject = BehaviorSubject<File>();

  Observable<File> get videoFileObservable => _videoFileBehaviourSubject.stream;

  BehaviorSubject<File> _thumbnailFileBehaviourSubject =
      BehaviorSubject<File>();

  Observable<File> get thumbnailFileObservable =>
      _thumbnailFileBehaviourSubject.stream;

  BehaviorSubject<bool> _safeAudienceBehaviourSubject = BehaviorSubject<bool>();

  Observable<bool> get safeObservable => _safeAudienceBehaviourSubject.stream;

  BehaviorSubject<bool> _publicAudienceBehaviourSubject =
      BehaviorSubject<bool>();

  Observable<bool> get publicObservable =>
      _publicAudienceBehaviourSubject.stream;

  /// Observable for category
  final BehaviorSubject<CategoryListModel> _categoryBehaviourSubject =
      BehaviorSubject<CategoryListModel>();

  Observable<CategoryListModel> get categoryObservable =>
      _categoryBehaviourSubject.stream;

  /// Observable for comments
  final BehaviorSubject<Resource<CommentResponse>> _commentsBehaviourSubject =
      BehaviorSubject<Resource<CommentResponse>>();

  Observable<Resource<CommentResponse>> get commentsObservable =>
      _commentsBehaviourSubject.stream;

  @override
  void handleEvent(VideoEvent event) {
    if (event is AddTagEvent) {
      _tags.add(event.tag);
      _tagBehaviourSubject.add(_tags);
    } else if (event is RemoveTagEvent) {
      _tags.remove(event.tag);
      _tagBehaviourSubject.add(_tags);
    } else if (event is UpdateTagEvent) {
      _tags = event.tags;
      _tagBehaviourSubject.add(event.tags);
    } else if (event is ChooseVideoEvent) {
      _pickVideo();
    } else if (event is UpdateSafeAudienceEvent) {
      _safeAudienceBehaviourSubject.add(event.safeValue);
    } else if (event is UpdatePublicAudienceEvent) {
      _publicAudienceBehaviourSubject.add(event.publicValue);
    } else if (event is UpdateCategoryDropDownValueEvent) {
      _fetchCategoryListFromPref(event);
    } else if (event is PickThumbnailEvent) {
      _pickThumbnail();
    } else if (event is UploadVideoDetailsEvent) {
      _uploadVideoDetails(event);
    } else if (event is UpdateVideoLikeStatusEvent) {
      _updateVideoLikeStatus(event);
    } else if (event is FetchCommentsEvent) {
      _fetchComments(event);
    } else if (event is AddCommentEvent) {
      _addComment(event);
    }
    else if(event is FetchCommenterAgencyProfileEvent){
      _fetchCommenterAgencyProfile(event);
    }
    else if(event is FetchCommenterArtistProfileEvent){
      _fetchCommenterArtistProfile(event);
    }
  }

  void _fetchCategoryListFromPref(
      UpdateCategoryDropDownValueEvent event) async {
    if (event.categoryListModel != null) {
      _categoryBehaviourSubject.add(
        CategoryListModel(
            categoryList: event.categoryListModel.categoryList,
            value: event.categoryListModel.value),
      );
    } else {
      SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
      List<CategoryModel> categoryList =
          await sharedPrefHandler.getCategoryList();
      if (categoryList != null && categoryList.length > 0) {
        _categoryBehaviourSubject.add(
          CategoryListModel(
            categoryList: categoryList,
            value: categoryList[0].name,
          ),
        );
      }
    }
  }

  Future _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoFileBehaviourSubject.add(video);
  }

  @override
  void dispose() {
    _tagBehaviourSubject.close();
    _videoFileBehaviourSubject.close();
    _safeAudienceBehaviourSubject.close();
    _publicAudienceBehaviourSubject.close();
    _categoryBehaviourSubject.close();
    _thumbnailFileBehaviourSubject.close();
    _commentsBehaviourSubject.close();
    super.dispose();
  }

  void _init() {
    _tagBehaviourSubject.add(_tags);
    _safeAudienceBehaviourSubject.add(false);
    _publicAudienceBehaviourSubject.add(false);
    _videoFileBehaviourSubject.add(null);
  }

  void _pickThumbnail() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _thumbnailFileBehaviourSubject.add(image);
  }

  void _uploadVideoDetails(UploadVideoDetailsEvent event) async {
    _logger.info("inside uplod video details}");
    final String tagString =
        this._tags.fold('', (p, c) => '$c${p != '' ? ',$p' : ''}');
    _logger.info("inside uplod video details$tagString");
    bool isSafe = await safeObservable.first;
    _logger.info("inside uplod video details$isSafe");

    bool isPublic = await publicObservable.first;
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    CategoryListModel categoryListModel = await categoryObservable.first;
    File thumbnail;
    if (_thumbnailFileBehaviourSubject.hasValue) {
      thumbnail = await thumbnailFileObservable.first;
    }
    File file;
    if (_videoFileBehaviourSubject.hasValue) {
      file = await videoFileObservable.first;
    }
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    _logger.info("artistid ${artistProfileResponse.id}");
    UploadVideoRequest uploadVideoRequest = UploadVideoRequest(
      title: event.title,
      description: event.description,
      tags: tagString,
      is_safe: isSafe ? "1" : "0",
      is_public: isPublic ? "1" : "0",
      category: categoryListModel.value,
      files: file,
      thumbnail: thumbnail,
      id: artistProfileResponse.id,
      video_id: event.videoId,
    );
    _logger.info(uploadVideoRequest.toString());
    Resource<SimpleMessageResponse> res =
        await _videoRepository.uploadVideo(uploadVideoRequest).last;
    if (res != null) {
      event.completer.complete(res.data.message);
    } else {
      event.completer.complete("Something Went Wrong!!!");
    }
    _videoFileBehaviourSubject.add(null);
  }

  void _updateVideoLikeStatus(UpdateVideoLikeStatusEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    LikeVideoRequest likeVideoRequest = LikeVideoRequest(
      vid: event.videoId,
      userid: artistProfileResponse.id,
    );
    if (artistProfileResponse != null) {
      Resource<SimpleMessageResponse> res =
          await _videoRepository.updateLikeVideoStatus(likeVideoRequest).last;
      if (res != null && res.data != null) {
        event.completer.complete(res.data.message);
      }
    }
  }

  Future _fetchComments(FetchCommentsEvent event) async {
    _commentsBehaviourSubject.add(null);
    Resource<CommentResponse> res =
        await _videoRepository.fetchComments(event.commentRequest).last;
    if (res != null && res.data != null) {
      _commentsBehaviourSubject.add(res);
    }
  }

  void _addComment(AddCommentEvent event) async {
    Resource<CommentModel> res =
        await _videoRepository.addComment(event.addCommentModel).last;
    if (res != null && res.data != null) {
      event.completer.complete(res.data);
    }
  }

  void _fetchCommenterAgencyProfile(FetchCommenterAgencyProfileEvent event) async{
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse = await sharedPrefHandler.getArtistBio();
    if(artistProfileResponse!=null){
      event.commenterProfileReqeust.copyWith(self_id: artistProfileResponse.id);
    }
    Resource<AgencyProfileResponse> res =  await    _videoRepository.fetchCommenterAgencyProfile(event.commenterProfileReqeust).last;

   if(res!=null && res.data!=null){
     event.completer.complete(res.data);
   }
  }

  void _fetchCommenterArtistProfile(FetchCommenterArtistProfileEvent event) async{
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse = await sharedPrefHandler.getArtistBio();
    CommenterProfileRequest commenterProfileRequest;
    if(artistProfileResponse!=null){
     commenterProfileRequest= event.commenterProfileReqeust.copyWith(self_id: artistProfileResponse.id,user_id: event.commenterProfileReqeust.user_id);
    }
    else{
      commenterProfileRequest = event.commenterProfileReqeust;
    }
    Resource<ArtistProfileResponse> res =  await    _videoRepository.fetchCommenterArtistProfile(commenterProfileRequest).last;
    if(res!=null && res.data!=null){
      _logger.info('${artistProfileResponse.id},  ${res.data.id}\n\n\n\n\n\n\n\n\n\n\n\n\n');
      if(artistProfileResponse.id==res.data.id){
        event.completer.complete('LOGGED_IN_ARTIST');
      }
      else{
        event.completer.complete(res.data);
      }
    }
  }
}
