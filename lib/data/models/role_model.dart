import 'package:json_annotation/json_annotation.dart';
part 'role_model.g.dart';

@JsonSerializable()
class RoleModel {
  String id;
  // ignore: non_constant_identifier_names
  String lang_id;
  String name;
  // ignore: non_constant_identifier_names
  String name_slug;
  String description;
  String keywords;
  String color;
  // ignore: non_constant_identifier_names
  String block_type;
  // ignore: non_constant_identifier_names
  String role_order;
  // ignore: non_constant_identifier_names
  String show_at_homepage;
  // ignore: non_constant_identifier_names
  String show_on_menu;
  // ignore: non_constant_identifier_names
  String created_at;

  RoleModel({
    this.id,
    // ignore: non_constant_identifier_names
    this.lang_id,
    this.name,
    // ignore: non_constant_identifier_names
    this.name_slug,
    this.description,
    this.keywords,
    this.color,
    // ignore: non_constant_identifier_names
    this.block_type,
    // ignore: non_constant_identifier_names
    this.role_order,
    // ignore: non_constant_identifier_names
    this.show_at_homepage,
    // ignore: non_constant_identifier_names
    this.show_on_menu,
    // ignore: non_constant_identifier_names
    this.created_at,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}
