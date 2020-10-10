// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['id'] as String,
    lang_id: json['lang_id'] as String,
    name: json['name'] as String,
    name_slug: json['name_slug'] as String,
    parent_id: json['parent_id'] as String,
    description: json['description'] as String,
    keywords: json['keywords'] as String,
    color: json['color'] as String,
    block_type: json['block_type'] as String,
    category_order: json['category_order'] as String,
    show_at_home_page: json['show_at_home_page'] as String,
    show_on_menu: json['show_on_menu'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang_id': instance.lang_id,
      'name': instance.name,
      'name_slug': instance.name_slug,
      'parent_id': instance.parent_id,
      'description': instance.description,
      'keywords': instance.keywords,
      'color': instance.color,
      'block_type': instance.block_type,
      'category_order': instance.category_order,
      'show_at_home_page': instance.show_at_home_page,
      'show_on_menu': instance.show_on_menu,
      'created_at': instance.created_at,
    };
