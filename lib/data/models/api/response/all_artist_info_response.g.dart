// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_artist_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllArtistInfoResponse _$AllArtistInfoResponseFromJson(
    Map<String, dynamic> json) {
  return AllArtistInfoResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ArtistProfileResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as String,
  );
}

Map<String, dynamic> _$AllArtistInfoResponseToJson(
        AllArtistInfoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };
