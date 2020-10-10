// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) {
  return RoleModel(
    id: json['id'] as String,
    lang_id: json['lang_id'] as String,
    name: json['name'] as String,
    name_slug: json['name_slug'] as String,
    description: json['description'] as String,
    keywords: json['keywords'] as String,
    color: json['color'] as String,
    block_type: json['block_type'] as String,
    role_order: json['role_order'] as String,
    show_at_homepage: json['show_at_homepage'] as String,
    show_on_menu: json['show_on_menu'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$RoleModelToJson(RoleModel instance) => <String, dynamic>{
      'id': instance.id,
      'lang_id': instance.lang_id,
      'name': instance.name,
      'name_slug': instance.name_slug,
      'description': instance.description,
      'keywords': instance.keywords,
      'color': instance.color,
      'block_type': instance.block_type,
      'role_order': instance.role_order,
      'show_at_homepage': instance.show_at_homepage,
      'show_on_menu': instance.show_on_menu,
      'created_at': instance.created_at,
    };
