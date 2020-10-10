import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
part 'artist_cred_response.g.dart';

@JsonSerializable()
class CredResponse {
  final List<CreditModel> data;
  final String success;
  final String message;

  CredResponse({this.data, this.success, this.message});

  factory CredResponse.fromJson(Map<String, dynamic> json) =>
      _$CredResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CredResponseToJson(this);
}
