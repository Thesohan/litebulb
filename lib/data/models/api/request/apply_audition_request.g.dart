// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_audition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyAuditionRequest _$ApplyAuditionRequestFromJson(Map<String, dynamic> json) {
  return ApplyAuditionRequest(
    agencyid: json['agencyid'] as String,
    artistid: json['artistid'] as String,
    postid: json['postid'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$ApplyAuditionRequestToJson(
        ApplyAuditionRequest instance) =>
    <String, dynamic>{
      'agencyid': instance.agencyid,
      'artistid': instance.artistid,
      'postid': instance.postid,
      'status': instance.status,
    };
