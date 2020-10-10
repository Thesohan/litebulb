import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/category_model.dart';
part 'category_model_response.g.dart';

@JsonSerializable()
class CategoryModelResponse {
  final List<CategoryModel> data;
  final String success;
  final String message;

  CategoryModelResponse({this.data, this.success, this.message});

  factory CategoryModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelResponseToJson(this);

  CategoryModelResponse copyWith({@required List<CategoryModel> data}) {
    return CategoryModelResponse(
      data: data ?? this.data,
      message: this.message,
      success: this.success,
    );
  }
}
