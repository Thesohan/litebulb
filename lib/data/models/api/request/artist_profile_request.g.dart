// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistProfileRequest _$ArtistProfileRequestFromJson(Map<String, dynamic> json) {
  return ArtistProfileRequest(
    id: json['id'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$ArtistProfileRequestToJson(
        ArtistProfileRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };
