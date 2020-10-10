import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/applied_audition_model.dart';
part 'applied_audition_response.g.dart';

@JsonSerializable()
class AppliedAuditionResponse {
  final String success;
  final List<AppliedAuditionModel> data;
  final String message;

  AppliedAuditionResponse({this.success, this.data, this.message});

  factory AppliedAuditionResponse.fromJson(Map<String, dynamic> json) =>
      _$AppliedAuditionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedAuditionResponseToJson(this);
}
