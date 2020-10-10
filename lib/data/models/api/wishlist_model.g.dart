// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) {
  return WishlistModel(
    audition: json['audition'] as String,
    vibe_user_id: json['vibe_user_id'] as String,
    post_id: json['post_id'] as String,
    added_on: json['added_on'] as String,
    auditionDetails: json['0'] == null
        ? null
        : AuditionResponse.fromJson(
            json['0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      'audition': instance.audition,
      'vibe_user_id': instance.vibe_user_id,
      'post_id': instance.post_id,
      'added_on': instance.added_on,
      '0': instance.auditionDetails,
    };
