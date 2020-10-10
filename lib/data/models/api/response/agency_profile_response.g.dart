// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyProfileResponse _$AgencyProfileResponseFromJson(
    Map<String, dynamic> json) {
  return AgencyProfileResponse(
    id: json['id'] as String,
    username: json['username'] as String,
    slug: json['slug'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    location: json['location'] as String,
    gender: json['gender'] as String,
    dob: json['dob'] as String,
    email: json['email'] as String,
    email_status: json['email_status'] as String,
    oauth_token: json['oauth_token'] as String,
    forgot_token: json['forgot_token'] as String,
    token: json['token'] as String,
    password: json['password'] as String,
    role: json['role'] as String,
    user_type: json['user_type'] as String,
    google_id: json['google_id'] as String,
    facebook_id: json['facebook_id'] as String,
    avatar: json['avatar'] as String,
    avatar_loc: json['avatar_loc'] as String,
    status: json['status'] as String,
    contact: json['contact'] as String,
    verified: json['verified'] as String,
    about_me: json['about_me'] as String,
    facebook_url: json['facebook_url'] as String,
    twitter_url: json['twitter_url'] as String,
    google_url: json['google_url'] as String,
    instagram_url: json['instagram_url'] as String,
    pinterest_url: json['pinterest_url'] as String,
    linkedin_url: json['linkedin_url'] as String,
    vk_url: json['vk_url'] as String,
    youtube_url: json['youtube_url'] as String,
    last_seen: json['last_seen'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$AgencyProfileResponseToJson(
        AgencyProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'slug': instance.slug,
      'name': instance.name,
      'category': instance.category,
      'location': instance.location,
      'gender': instance.gender,
      'dob': instance.dob,
      'email': instance.email,
      'email_status': instance.email_status,
      'oauth_token': instance.oauth_token,
      'forgot_token': instance.forgot_token,
      'token': instance.token,
      'password': instance.password,
      'role': instance.role,
      'user_type': instance.user_type,
      'google_id': instance.google_id,
      'facebook_id': instance.facebook_id,
      'avatar': instance.avatar,
      'avatar_loc': instance.avatar_loc,
      'status': instance.status,
      'contact': instance.contact,
      'verified': instance.verified,
      'about_me': instance.about_me,
      'facebook_url': instance.facebook_url,
      'twitter_url': instance.twitter_url,
      'google_url': instance.google_url,
      'instagram_url': instance.instagram_url,
      'pinterest_url': instance.pinterest_url,
      'linkedin_url': instance.linkedin_url,
      'vk_url': instance.vk_url,
      'youtube_url': instance.youtube_url,
      'last_seen': instance.last_seen,
      'created_at': instance.created_at,
    };
