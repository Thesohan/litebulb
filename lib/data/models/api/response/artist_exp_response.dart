import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
part 'artist_exp_response.g.dart';

@JsonSerializable()
class ExpOrProResponse {
  final List<ArtistExperienceModel> data;
  final String success;
  final String message;

  ExpOrProResponse({this.data, this.success, this.message});

  factory ExpOrProResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpOrProResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpOrProResponseToJson(this);
}
