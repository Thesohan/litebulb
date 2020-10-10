import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/role_model.dart';
part 'role_list_response.g.dart';

@JsonSerializable()
class RoleListResponse {
  final List<RoleModel> data;
  final String success;
  final String message;

  RoleListResponse({
    this.data,
    this.success,
    this.message,
  });

  factory RoleListResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoleListResponseToJson(this);
}
