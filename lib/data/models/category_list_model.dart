import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/data/models/category_model.dart';

class CategoryListModel {
  final List<CategoryModel> categoryList;
  final String value;

  CategoryListModel({@required this.categoryList, @required this.value})
      : assert(
          categoryList != null,
          value != null,
        );
}
