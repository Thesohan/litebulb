import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String id;
  // ignore: non_constant_identifier_names
  final String lang_id;
  final String name;
  // ignore: non_constant_identifier_names
  final String name_slug;
  // ignore: non_constant_identifier_names
  final String parent_id;
  final String description;
  final String keywords;
  final String color;
  // ignore: non_constant_identifier_names
  final String block_type;
  // ignore: non_constant_identifier_names
  final String category_order;
  // ignore: non_constant_identifier_names
  final String show_at_home_page;
  // ignore: non_constant_identifier_names
  final String show_on_menu;
  // ignore: non_constant_identifier_names
  final String created_at;

  CategoryModel({
    this.id,
    // ignore: non_constant_identifier_names
    this.lang_id,
    this.name,
    // ignore: non_constant_identifier_names
    this.name_slug,
    // ignore: non_constant_identifier_names
    this.parent_id,
    this.description,
    this.keywords,
    this.color,
    // ignore: non_constant_identifier_names
    this.block_type,
    // ignore: non_constant_identifier_names
    this.category_order,
    // ignore: non_constant_identifier_names
    this.show_at_home_page,
    // ignore: non_constant_identifier_names
    this.show_on_menu,
    // ignore: non_constant_identifier_names
    this.created_at,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
