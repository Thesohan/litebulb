import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_id.g.dart';

@JsonSerializable()
class IdRequest {
  final String id;

  IdRequest({@required this.id});

  factory IdRequest.fromJson(Map<String, dynamic> json) =>
      _$IdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IdRequestToJson(this);
}
