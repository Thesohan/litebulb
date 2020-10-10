import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artist_category_request.g.dart';

@JsonSerializable()
class ArtistCategoryRequest {
  final String category;
  // ignore: non_constant_identifier_names
  final String user_id;

  // ignore: non_constant_identifier_names
  ArtistCategoryRequest( {@required this.category,this.user_id,});

  factory ArtistCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$ArtistCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistCategoryRequestToJson(this);
}
