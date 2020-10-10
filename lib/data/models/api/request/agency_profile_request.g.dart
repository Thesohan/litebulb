// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyProfileRequest _$AgencyProfileRequestFromJson(Map<String, dynamic> json) {
  return AgencyProfileRequest(
    username: json['username'] as String,
    artist_id: json['artist_id'] as String,
  );
}

Map<String, dynamic> _$AgencyProfileRequestToJson(
        AgencyProfileRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'artist_id': instance.artist_id,
    };
