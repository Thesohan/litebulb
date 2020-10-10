import 'dart:io';

import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';

class UploadProfilePicRequest {
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
  final File thumbnail;

  UploadProfilePicRequest({
    this.id,
    this.email,
    this.pass,
    this.password,
    this.date_registered,
    this.last_login,
    this.groupId,
    this.avatar,
    this.avatar_loc,
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

  UploadProfilePicRequest copyWith({
    File thumbnail,
    ArtistProfileResponse artistProfileResponse,
  }) {
    return UploadProfilePicRequest(
      id: artistProfileResponse.id ?? this.id,
      email: artistProfileResponse.email ?? this.email,
      password: artistProfileResponse.password ?? this.password,
      pass: artistProfileResponse.pass ?? this.pass,
      date_registered:
          artistProfileResponse.date_registered ?? this.date_registered,
      last_login: artistProfileResponse.last_login ?? this.last_login,
      groupId: artistProfileResponse.groupId ?? this.groupId,
      avatar: artistProfileResponse.avatar ?? this.avatar,
      avatar_loc: artistProfileResponse.avatar_loc ?? this.avatar_loc,
      name: artistProfileResponse.name ?? this.name,
      username: artistProfileResponse.username ?? this.username,
      type: artistProfileResponse.type ?? this.type,
      grid: artistProfileResponse.grid ?? this.grid,
      fid: artistProfileResponse.fid ?? this.fid,
      oauth_token: artistProfileResponse.oauth_token ?? this.oauth_token,
      forgot_token: artistProfileResponse.forgot_token ?? this.forgot_token,
      verified: artistProfileResponse.verified ?? this.verified,
      local: artistProfileResponse.local ?? this.local,
      country: artistProfileResponse.country ?? this.country,
      contact: artistProfileResponse.contact ?? this.contact,
      bio: artistProfileResponse.bio ?? this.bio,
      about: artistProfileResponse.about ?? this.about,
      skills: artistProfileResponse.skills ?? this.skills,
      age: artistProfileResponse.age ?? this.age,
      language: artistProfileResponse.language ?? this.language,
      birthday: artistProfileResponse.birthday ?? this.birthday,
      skintone: artistProfileResponse.skintone ?? this.skintone,
      hips: artistProfileResponse.hips ?? this.hips,
      height: artistProfileResponse.height ?? this.height,
      butchest: artistProfileResponse.butchest ?? this.butchest,
      waist: artistProfileResponse.waist ?? this.waist,
      category: artistProfileResponse.category ?? this.category,
      views: artistProfileResponse.views ?? this.views,
      fblink: artistProfileResponse.fblink ?? this.fblink,
      twlink: artistProfileResponse.twlink ?? this.twlink,
      glink: artistProfileResponse.glink ?? this.glink,
      gender: artistProfileResponse.gender ?? this.gender,
      lastNoty: artistProfileResponse.lastNoty ?? this.lastNoty,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}
