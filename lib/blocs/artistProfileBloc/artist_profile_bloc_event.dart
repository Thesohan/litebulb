import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';

class FetchArtistProfileDataEvent extends BaseEvent {}

class FetchArtistBioEvent extends FetchArtistProfileDataEvent {}

class FetchArtistExpOrCredEvent extends FetchArtistProfileDataEvent {
  final String value;

  FetchArtistExpOrCredEvent({@required this.value}) : assert(value != null);

  @override
  String toString() {
    return 'FetchArtistExpOrCredEvent{value: $value}';
  }
}

class UpdateShowAllPressStatus extends FetchArtistProfileDataEvent {
  final bool isShowAllPressed;
  final bool isExperience;
  final bool isOtherArtist;
  UpdateShowAllPressStatus(
      {@required this.isExperience,
      @required this.isShowAllPressed,
      this.isOtherArtist = false});

  @override
  String toString() {
    return 'UpdateShowAllPressStatus{isShowAllPressed:$isShowAllPressed,'
        'isExperience:$isExperience,'
        'isOtherArtist:$isOtherArtist';
  }
}

class UpdateProfileEvent extends FetchArtistProfileDataEvent {
  final File thumbnail;
  final Completer completer;

  UpdateProfileEvent({@required this.thumbnail, @required this.completer});

  @override
  String toString() {
    return 'UpdateProfileEvent{file}';
  }
}

class FetchOtherArtistExpOrCredEvent extends FetchArtistProfileDataEvent {
  final String value;
  final String id;

  FetchOtherArtistExpOrCredEvent({@required this.value, @required this.id})
      : assert(value != null && id != null);

  @override
  String toString() {
    return 'FetchArtistExpOrCredEvent{value: $value,'
        'id:$id}';
  }
}

class SubscriptionEvent extends FetchArtistProfileDataEvent {
  final String followingId;
  final Completer completer;
  SubscriptionEvent({@required this.followingId, @required this.completer})
      : assert(followingId != null && completer != null);

  @override
  String toString() {
    return 'SubscriptionEvent{followingId:$followingId';
  }
}

class FetchArtistCreditsFromPref extends FetchArtistProfileDataEvent {}

class FetchArtistExperienceFromPref extends FetchArtistProfileDataEvent {}

class FetchArtistVideoEvent extends FetchArtistProfileDataEvent {
  final String artistId;

  FetchArtistVideoEvent({this.artistId});
}

class FetchNoOfSubscriberEvent extends FetchArtistProfileDataEvent {
  final String followingId;

  FetchNoOfSubscriberEvent({this.followingId});

  @override
  String toString() {
    return 'FetchNoOfSubscriberEvent{followingId:$followingId}';
  }
}
