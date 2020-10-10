import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/data/models/api/add_comment_model.dart';
import 'package:new_artist_project/data/models/api/request/comment_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/response/comment_response.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';

class VideoEvent extends BaseEvent {}

class AddTagEvent extends VideoEvent {
  final String tag;

  AddTagEvent({@required this.tag}) : assert(tag != null);

  @override
  String toString() {
    return 'AddTagEvent{tag:$tag}';
  }
}

class RemoveTagEvent extends VideoEvent {
  final String tag;

  RemoveTagEvent({@required this.tag}) : assert(tag != null);
  @override
  String toString() {
    return 'RemoveTagEvent{tag:$tag}';
  }
}

class UpdateTagEvent extends VideoEvent {
  final Set<String> tags;

  UpdateTagEvent({@required this.tags}) : assert(tags != null);

  @override
  String toString() {
    return 'UpdateTagEvent{tags:$tags}';
  }
}

class ChooseVideoEvent extends VideoEvent {}

class UpdateSafeAudienceEvent extends VideoEvent {
  final bool safeValue;

  UpdateSafeAudienceEvent({@required this.safeValue})
      : assert(safeValue != null);
  @override
  String toString() {
    return 'UpdateSafeAudienceEvent{safeValue:$safeValue}';
  }
}

class UpdatePublicAudienceEvent extends VideoEvent {
  final bool publicValue;

  UpdatePublicAudienceEvent({@required this.publicValue})
      : assert(publicValue != null);
  @override
  String toString() {
    return 'UpdatePublicAudienceEvent{publicValue:$publicValue}';
  }
}

class UpdateCategoryDropDownValueEvent extends VideoEvent {
  final CategoryListModel categoryListModel;
  UpdateCategoryDropDownValueEvent({this.categoryListModel});

  @override
  String toString() {
    return 'UpdateCategoryDropDownValueEvent{categoryListModel:$categoryListModel}';
  }
}

class PickThumbnailEvent extends VideoEvent {}

class UploadVideoDetailsEvent extends VideoEvent {
  final Completer completer;
  final String description;
  final String title;
  final String videoId;
  UploadVideoDetailsEvent({
    @required this.completer,
    this.description,
    this.title,
    this.videoId,
  }) : assert(completer != null);
}

class UpdateVideoLikeStatusEvent extends VideoEvent {
  final String videoId;
  final Completer completer;

  UpdateVideoLikeStatusEvent({
    @required this.videoId,
    @required this.completer,
  }) : assert(videoId != null && completer != null);
}

class FetchCommentsEvent extends VideoEvent {
  final CommentRequest commentRequest;

  FetchCommentsEvent({@required this.commentRequest});

  @override
  String toString() {
    return 'FetchCommentsEvent{CommentRequest:${commentRequest.object_id}}';
  }
}

class AddCommentEvent extends VideoEvent {
  final AddCommentModel addCommentModel;
  final Completer completer;

  AddCommentEvent({
    @required this.addCommentModel,
    @required this.completer,
  });

  @override
  String toString() {
    return 'AddCommentEvent{addCommentModel:$addCommentModel,'
        'completer:$completer}';
  }
}

class FetchCommenterAgencyProfileEvent extends VideoEvent {
  final CommenterProfileRequest commenterProfileReqeust;
  final Completer completer;

  FetchCommenterAgencyProfileEvent(
      {@required this.commenterProfileReqeust, @required this.completer})
      : assert(
          commenterProfileReqeust != null && completer != null,
        );
}


class FetchCommenterArtistProfileEvent extends VideoEvent {
  final CommenterProfileRequest commenterProfileReqeust;
  final Completer completer;

  FetchCommenterArtistProfileEvent(
      {@required this.commenterProfileReqeust, @required this.completer})
      : assert(
  commenterProfileReqeust != null && completer != null,
  );
}
