import 'package:json_annotation/json_annotation.dart';
part 'register_artist_request.g.dart';
@JsonSerializable()
class RegisterArtistRequest{
  final String username;
  final String email;
  final String number;
  final String password;

  RegisterArtistRequest({this.username, this.email, this.number, this.password,});

  factory RegisterArtistRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterArtistRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterArtistRequestToJson(this);
}