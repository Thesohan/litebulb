// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModelResponse _$CategoryModelResponseFromJson(
    Map<String, dynamic> json) {
  return CategoryModelResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: json['success'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CategoryModelResponseToJson(
        CategoryModelResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
