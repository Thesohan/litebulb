// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_all_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistAllVideoResponse _$ArtistAllVideoResponseFromJson(
    Map<String, dynamic> json) {
  return ArtistAllVideoResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ArtistVideoResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as String,
  );
}

Map<String, dynamic> _$ArtistAllVideoResponseToJson(
        ArtistAllVideoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };
