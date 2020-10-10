// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_experience_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistExperienceModel _$ArtistExperienceModelFromJson(
    Map<String, dynamic> json) {
  return ArtistExperienceModel(
    p_id: json['p_id'] as String,
    id: json['id'] as String,
    project_name: json['project_name'] as String,
    role: json['role'] as String,
    project_details: json['project_details'] as String,
  );
}

Map<String, dynamic> _$ArtistExperienceModelToJson(
        ArtistExperienceModel instance) =>
    <String, dynamic>{
      'p_id': instance.p_id,
      'id': instance.id,
      'project_name': instance.project_name,
      'role': instance.role,
      'project_details': instance.project_details,
    };
