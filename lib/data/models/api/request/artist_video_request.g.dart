// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_video_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistVideoRequest _$ArtistVideoRequestFromJson(Map<String, dynamic> json) {
  return ArtistVideoRequest(
    artistid: json['artistid'] as String,
    videoid: json['videoid'] as String,
    userid: json['userid'] as String,
  );
}

Map<String, dynamic> _$ArtistVideoRequestToJson(ArtistVideoRequest instance) =>
    <String, dynamic>{
      'artistid': instance.artistid,
      'videoid': instance.videoid,
      'userid': instance.userid,
    };
