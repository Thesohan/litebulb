import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/data/models/api/request/add_to_wishlist_request.dart';
import 'package:new_artist_project/data/models/api/request/applied_audition_by_artist_request.dart';
import 'package:new_artist_project/data/models/api/request/apply_audition_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/audition_model.dart';

class AuditionEvent extends BaseEvent{}

class FetchFeaturedAuditionBlocEvent extends AuditionEvent {
  final AuditionRequest auditionRequest;

  FetchFeaturedAuditionBlocEvent({@required this.auditionRequest});

  @override
  String toString() {
    return 'FetchFeaturedAuditionBlocEvent{audtionRequest:$auditionRequest}';
  }
}

class FetchCategoryEvent extends AuditionEvent{
  final String id;

  FetchCategoryEvent({@required this.id}) : assert(id != null);
  @override
  String toString() {
    return 'FetchCategoryEvent{id:$id}';
  }
}

class FetchSubCategoryEvent extends AuditionEvent{
  final String id;

  FetchSubCategoryEvent({@required this.id}) : assert(id != null);
  @override
  String toString() {
    return 'FetchSubCategoryEvent{id:$id}';
  }
}

class GetRolesEvent extends AuditionEvent {
  final String id;

  GetRolesEvent({@required this.id}) : assert(id != null);
  @override
  String toString() {
    return 'GetRolesEvent{id:$id}';
  }
}

class FetchAgencyAuditionEvent extends AuditionEvent {
  final AuditionRequest auditionRequest;

  FetchAgencyAuditionEvent({@required this.auditionRequest})
      : assert(auditionRequest != null);

  @override
  String toString() {
    return 'FetchAgencyAuditionEvent{auditionRequest:${auditionRequest.user_id} ${auditionRequest.category}';
  }
}

class AddToWishlistEvent extends AuditionEvent{
  final AddToWishlistRequest addToWishlistRequest;
  final Completer completer;

  AddToWishlistEvent(
      {@required this.addToWishlistRequest, @required this.completer});

  @override
  String toString() {
    return 'AddToWishlistEvent{AddToWishListRequest:$addToWishlistRequest}';
  }

  AddToWishlistEvent copyWith(
      {AddToWishlistRequest addToWishlistRequest, Completer completer}) {
    return AddToWishlistEvent(
      addToWishlistRequest: addToWishlistRequest ?? this.addToWishlistRequest,
      completer: completer ?? this.completer,
    );
  }
}

class ApplyAuditionEvent extends AuditionEvent {
  final ApplyAuditionRequest appliedAuditionRequest;
  final Completer completer;

  ApplyAuditionEvent(
      {@required this.appliedAuditionRequest, @required this.completer});
  @override
  String toString() {
    return 'ApplyAuditionEvent{ApplyAuditionRequest:$appliedAuditionRequest}';
  }
}

class LaunchUrlEvent extends AuditionEvent {
  final String url;

  LaunchUrlEvent({@required this.url}) : assert(url != null);

  @override
  String toString() {
    return 'LaunchUrlEvent{url:$url}';
  }
}

class FetchAppliedAuditionEvent extends AuditionEvent {}

class FetchWishlistEvent extends AuditionEvent {}
class FetchAuditionAgencyDetailsEvent extends AuditionEvent{
  final String username;
  final Completer completer;

  FetchAuditionAgencyDetailsEvent({@required this.username,@required this.completer});

  @override
  String toString() {
    return 'FetchAuditionAgencyDetailsEvent{'
        'username:$username,'
        'completer:$completer}';
  }
}