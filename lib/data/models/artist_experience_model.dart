import 'package:json_annotation/json_annotation.dart';
part 'artist_experience_model.g.dart';

@JsonSerializable()
class ArtistExperienceModel {
  // ignore: non_constant_identifier_names
  final String p_id;
  final String id;
  // ignore: non_constant_identifier_names
  final String project_name;
  final String role;
  // ignore: non_constant_identifier_names
  final String project_details;

  ArtistExperienceModel({
    // ignore: non_constant_identifier_names
    this.p_id,
    this.id,
    // ignore: non_constant_identifier_names
    this.project_name,
    this.role,
    // ignore: non_constant_identifier_names
    this.project_details,
  });

  ArtistExperienceModel copyWith({
    String p_id,
    String id,
    String project_name,
    String role,
    String project_details,
  }) {
    return ArtistExperienceModel(
        p_id: p_id ?? this.p_id,
        id: id ?? this.id,
        project_name: project_name ?? this.project_name,
        role: role ?? this.role,
        project_details: project_details ?? this.project_details);
  }

  factory ArtistExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistExperienceModelToJson(this);
}
