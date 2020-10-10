import 'package:json_annotation/json_annotation.dart';
part 'agency_profile_response.g.dart';

@JsonSerializable()
class AgencyProfileResponse {
  final String id;
  final String username;
  final String slug;
  final String name;
  final String category;
  final String location;
  final String gender;
  final String dob;
  final String email;
  final String email_status;
  final String oauth_token;
  final String forgot_token;
  final String token;
  final String password;
  final String role;
  final String user_type;
  final String google_id;
  final String facebook_id;
  final String avatar;
  final String avatar_loc;
  final String status;
  final String contact;
  final String verified;
// ignore: non_constant_identifier_names
  final String about_me;
// ignore: non_constant_identifier_names
  final String facebook_url;
// ignore: non_constant_identifier_names
  final String twitter_url;
// ignore: non_constant_identifier_names
  final String google_url;
// ignore: non_constant_identifier_names
  final String instagram_url;
// ignore: non_constant_identifier_names
  final String pinterest_url;
// ignore: non_constant_identifier_names
  final String linkedin_url;
// ignore: non_constant_identifier_names
  final String vk_url;
// ignore: non_constant_identifier_names
  final String youtube_url;
// ignore: non_constant_identifier_names
  final String last_seen;
// ignore: non_constant_identifier_names
  final String created_at;

  // ignore: non_constant_identifier_names
  AgencyProfileResponse({
    this.id,
    this.username,
    this.slug,
    this.name,
    this.category,
    this.location,
    this.gender,
    this.dob,
    this.email,
    this.email_status,
    this.oauth_token,
    this.forgot_token,
    this.token,
    this.password,
    this.role,
    this.user_type,
    this.google_id,
    this.facebook_id,
    this.avatar,
    this.avatar_loc,
    this.status,
    this.contact,
    this.verified,
    this.about_me,
    this.facebook_url,
    this.twitter_url,
    this.google_url,
    this.instagram_url,
    this.pinterest_url,
    this.linkedin_url,
    this.vk_url,
    this.youtube_url,
    this.last_seen,
    this.created_at,
  });

  factory AgencyProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyProfileResponseToJson(this);
}
