// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistCategoryRequest _$ArtistCategoryRequestFromJson(
    Map<String, dynamic> json) {
  return ArtistCategoryRequest(
    category: json['category'] as String,
    user_id: json['user_id'] as String,
  );
}

Map<String, dynamic> _$ArtistCategoryRequestToJson(
        ArtistCategoryRequest instance) =>
    <String, dynamic>{
      'category': instance.category,
      'user_id': instance.user_id,
    };
