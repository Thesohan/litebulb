// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_artist_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterArtistRequest _$RegisterArtistRequestFromJson(
    Map<String, dynamic> json) {
  return RegisterArtistRequest(
    username: json['username'] as String,
    email: json['email'] as String,
    number: json['number'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegisterArtistRequestToJson(
        RegisterArtistRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'number': instance.number,
      'password': instance.password,
    };
