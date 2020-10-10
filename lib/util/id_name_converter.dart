import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/models/role_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdNameConverter {
  final List<CategoryModel> categoryList;

  IdNameConverter({this.categoryList});

  String getCategoryNameFromId({@required String categoryId}) {
    for (int i = 0; i < this.categoryList.length; i++) {
      if (this.categoryList[i].id == categoryId.toString()) {
        return this.categoryList[i].name;
      }
    }
    return "";
  }

  String getCategoryIdFromName({@required String name}) {
    for (int i = 0; i < this.categoryList.length; i++) {
      if (this.categoryList[i].name == name) {
        return this.categoryList[i].id;
      }
    }
    return "";
  }

  Future<String> getRoleNameFromId({@required String roleId}) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    List<RoleModel> roles = await sharedPrefHandler.getRoleList();
    int index = roles.indexWhere((role) => role.id == roleId);
    if (index >= 0) {
      return roles[index].name;
    }
    return null;
  }
}
