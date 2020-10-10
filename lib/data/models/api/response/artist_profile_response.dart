import 'dart:core';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'artist_profile_response.g.dart';

@JsonSerializable()
class ArtistProfileResponse {
  final String id;
  final String email;
  final String pass;
  final String password;
  // ignore: non_constant_identifier_names
  final String date_registered;
  // ignore: non_constant_identifier_names
  final String last_login;
  final String groupId;
  final String avatar;
  // ignore: non_constant_identifier_names
  final String avatar_loc;
  final String cover;
  final String name;
  final String username;
  final String type;
  final String grid;
  final String fid;
  // ignore: non_constant_identifier_names
  final String oauth_token;
  // ignore: non_constant_identifier_names
  final String forgot_token;
  final String verified;
  final String local;
  final String country;
  final String contact;
  final String bio;
  final String about;
  final String skills;
  final String age;
  final String language;
  final String birthday;
  final String skintone;
  final String hips;
  final String height;
  final String butchest;
  final String waist;
  final String category;
  final String views;
  final String fblink;
  final String twlink;
  final String glink;
  final String iglink;
  final String gender;
  final String lastNoty;
  final String thumbnail;
  final String is_subscribed;
  final String is_addedtowishlist;

  ArtistProfileResponse({
    this.is_subscribed='0',
    this.is_addedtowishlist='0',
    this.id,
    this.email,
    this.avatar_loc,
    this.pass,
    this.password,
    this.date_registered,
    this.last_login,
    this.groupId,
    this.avatar,
    this.cover,
    this.name,
    this.username,
    this.type,
    this.grid,
    this.fid,
    this.oauth_token,
    this.forgot_token,
    this.verified,
    this.local,
    this.country,
    this.contact,
    this.bio,
    this.about,
    this.skills,
    this.age,
    this.language,
    this.birthday,
    this.skintone,
    this.hips,
    this.height,
    this.butchest,
    this.waist,
    this.category,
    this.views,
    this.fblink,
    this.twlink,
    this.glink,
    this.iglink,
    this.gender,
    this.lastNoty,
    this.thumbnail,
  });

  ArtistProfileResponse copyWith({
    String id,
    String email,
    String pass,
    String password,
    // ignore: non_constant_identifier_names
    String date_registered,
    // ignore: non_constant_identifier_names
    String last_login,
    String groupId,
    String avatar,
    String avatar_loc,
    String cover,
    String name,
    String username,
    String type,
    String grid,
    String fid,
    // ignore: non_constant_identifier_names
    String oauth_token,
    // ignore: non_constant_identifier_names
    String forgot_token,
    String verified,
    String local,
    String country,
    String contact,
    String bio,
    String about,
    String skills,
    String age,
    String language,
    String birthday,
    String skintone,
    String hips,
    String height,
    String butchest,
    String waist,
    String category,
    String views,
    String fblink,
    String twlink,
    String glink,
    String iglink,
    String gender,
    String lastNoty,
    String thumbnail,
    String is_subscribed,
    String is_addedtowishlist,
  }) {
    return ArtistProfileResponse(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      pass: pass ?? this.pass,
      date_registered: date_registered ?? this.date_registered,
      last_login: last_login ?? this.last_login,
      groupId: groupId ?? this.groupId,
      avatar: avatar ?? this.avatar,
      avatar_loc: avatar_loc ?? this.avatar_loc,
      name: name ?? this.name,
      username: username ?? this.username,
      type: type ?? this.type,
      grid: grid ?? this.grid,
      fid: fid ?? this.fid,
      oauth_token: oauth_token ?? this.oauth_token,
      forgot_token: forgot_token ?? this.forgot_token,
      verified: verified ?? this.verified,
      local: local ?? this.local,
      country: country ?? this.country,
      contact: contact ?? this.contact,
      bio: bio ?? this.bio,
      about: about ?? this.about,
      skills: skills ?? this.skills,
      age: age ?? this.age,
      language: language ?? this.language,
      birthday: birthday ?? this.birthday,
      skintone: skintone ?? this.skintone,
      hips: hips ?? this.hips,
      height: height ?? this.height,
      butchest: butchest ?? this.butchest,
      waist: waist ?? this.waist,
      category: category ?? this.category,
      views: views ?? this.views,
      fblink: fblink ?? this.fblink,
      twlink: twlink ?? this.twlink,
      glink: glink ?? this.glink,
      gender: gender ?? this.gender,
      lastNoty: lastNoty ?? this.lastNoty,
      thumbnail: thumbnail ?? this.thumbnail,
      is_subscribed: is_subscribed??this.is_subscribed,
      is_addedtowishlist: is_addedtowishlist??this.is_addedtowishlist,
    );
  }

  Map<String, dynamic> toJson() => _$ArtistProfileResponseToJson(this);
  factory ArtistProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistProfileResponseFromJson(json);

  @override
  String toString() {
    return 'ArtistProfileResponse{about:$about,'
        'gender:$gender,'
        'category:$category,'
        'skills:$skills,'
        'languages:$language,'
        'birthday:$birthday,'
        'age:$age,'
        'butchest:$butchest,'
        'height:$height,'
        'skintone:$skintone,'
        'is_subscribe:$is_subscribed';
  }
}
