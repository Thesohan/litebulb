import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/audition_model.dart';
part 'audition_list_response.g.dart';

@JsonSerializable()
class AuditionListResponse {
  final List<AuditionResponse> data;
  final String message;
  final String success;

  AuditionListResponse({
    this.data,
    this.message,
    this.success,
  });

  AuditionListResponse copyWith(List<AuditionResponse> data) {
    return AuditionListResponse(
      data: data ?? this.data,
      message: this.message,
      success: this.success,
    );
  }

  factory AuditionListResponse.fromJson(Map<String, dynamic> json) =>
      _$AuditionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuditionListResponseToJson(this);
}
