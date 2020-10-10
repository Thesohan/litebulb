import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
part 'applied_audition_model.g.dart';

@JsonSerializable()
class AppliedAuditionModel {
  final String auditionUserId;
  final String postId;
  final String vibeUserId;
  final String appliedAt;
  final String status;
  final String statusUpdatedon;
  final AuditionResponse auditionDetails;

  AppliedAuditionModel({
    this.auditionUserId,
    this.postId,
    this.auditionDetails,
    this.vibeUserId,
    this.appliedAt,
    this.status,
    this.statusUpdatedon,
  });

  factory AppliedAuditionModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedAuditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedAuditionModelToJson(this);
}
