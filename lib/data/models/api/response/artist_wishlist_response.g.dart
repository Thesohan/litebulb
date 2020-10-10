// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_wishlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistWishlistResponse _$ArtistWishlistResponseFromJson(
    Map<String, dynamic> json) {
  return ArtistWishlistResponse(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WishlistModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArtistWishlistResponseToJson(
        ArtistWishlistResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
