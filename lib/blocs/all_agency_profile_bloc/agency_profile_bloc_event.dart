import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
class AgencyDataEvent extends BaseEvent{}
class FetchAllAgencyEvent extends AgencyDataEvent {
  final AgencyProfileRequest agencyProfileRequest;

  FetchAllAgencyEvent({@required this.agencyProfileRequest})
      : assert(agencyProfileRequest != null);

  @override
  String toString() {
    return 'FetchAllAgencyEvent{agencyProfileRequest:$agencyProfileRequest}';
  }
}

class FetchAgencyExpOrCredEvent extends AgencyDataEvent {
  final String value;
  final String id;

  FetchAgencyExpOrCredEvent({
    @required this.value,
    @required this.id,
  }) : assert(value != null && id != null);

  @override
  String toString() {
    return 'FetchAgencyExpOrCredEvent{value: $value,id$id,}';
  }
}



class FetchBlockedAgencyEvent extends AgencyDataEvent {}

class BlockOrUnBlockAgencyEvent extends AgencyDataEvent{
  final String agencyId;
  final Completer completer;
  final bool isBlocEvent;

  BlockOrUnBlockAgencyEvent({this.agencyId,this.completer,this.isBlocEvent=false}):assert(completer!=null&& agencyId!=null);
}