import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'audition_request.g.dart';

@JsonSerializable()
class AuditionRequest {
// ignore: non_constant_identifier_names
  final String user_id;
  final String category;
// ignore: non_constant_identifier_names
  final String is_featured;
  final String agency_id;

// ignore: non_constant_identifier_names
  AuditionRequest({
    this.user_id,
    this.category,
    @required this.is_featured,
    @required this.agency_id,
  });

  factory AuditionRequest.fromJson(Map<String, dynamic> json) =>
      _$AuditionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuditionRequestToJson(this);

  AuditionRequest copyWith({
  String userId,
    String category,
    String agencyId,
    String isFeatured
}){
    return AuditionRequest(
      user_id: userId??this.user_id,
      category: category??this.category,
      is_featured: isFeatured??this.is_featured,
      agency_id: agencyId??this.agency_id
    );
  }
}
