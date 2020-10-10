// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_wishlist_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToWishlistRequest _$AddToWishlistRequestFromJson(Map<String, dynamic> json) {
  return AddToWishlistRequest(
    agencyid: json['agencyid'] as String,
    artistid: json['artistid'] as String,
    postid: json['postid'] as String,
  );
}

Map<String, dynamic> _$AddToWishlistRequestToJson(
        AddToWishlistRequest instance) =>
    <String, dynamic>{
      'agencyid': instance.agencyid,
      'artistid': instance.artistid,
      'postid': instance.postid,
    };
