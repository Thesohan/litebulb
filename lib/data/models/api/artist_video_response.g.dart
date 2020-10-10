// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistVideoResponse _$ArtistVideoResponseFromJson(Map<String, dynamic> json) {
  return ArtistVideoResponse(
    id: json['id'] as String,
    artist_id: json['artist_id'] as String,
    title: json['title'] as String,
    Category: json['Category'] as String,
    description: json['description'] as String,
    video_id: json['video_id'] as String,
    video: json['video'] as String,
    thumbnail: json['thumbnail'] as String,
    location: json['location'] as String,
    thumbnail_url: json['thumbnail_url'] as String,
    tags: json['tags'] as String,
    uploaded_at: json['uploaded_at'] as String,
    is_safe: json['is_safe'] as String,
    is_public: json['is_public'] as String,
    is_liked: json['is_liked'] as String,
    no_oflikes: json['no_oflikes'] as String,
  );
}

Map<String, dynamic> _$ArtistVideoResponseToJson(
        ArtistVideoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artist_id': instance.artist_id,
      'title': instance.title,
      'Category': instance.Category,
      'description': instance.description,
      'video_id': instance.video_id,
      'video': instance.video,
      'thumbnail': instance.thumbnail,
      'location': instance.location,
      'thumbnail_url': instance.thumbnail_url,
      'tags': instance.tags,
      'uploaded_at': instance.uploaded_at,
      'is_safe': instance.is_safe,
      'is_public': instance.is_public,
      'is_liked': instance.is_liked,
      'no_oflikes': instance.no_oflikes,
    };
