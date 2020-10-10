import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';

class CategoryBlocEvent extends BaseEvent {
  final IdRequest categoryRequest;

  CategoryBlocEvent({@required this.categoryRequest})
      : assert(categoryRequest != null);

  @override
  String toString() {
    return 'CategoryBlocEvent{ categoryRequestId: ${categoryRequest.id}';
  }
}

class GetCategoryEvent extends BaseEvent {}

class GetSubCategoryEvent extends BaseEvent {}

class UpdateCategoryDropDownValue extends BaseEvent {
  final CategoryListModel categoryListModel;
  UpdateCategoryDropDownValue({@required this.categoryListModel})
      : assert(categoryListModel != null);

  @override
  String toString() {
    return 'UpdateCategoryDropDownValue{categoryListModel:$categoryListModel';
  }
}

class FetchRoleTypeListEvent extends BaseEvent {
  final IdRequest roleRequest;

  FetchRoleTypeListEvent({@required this.roleRequest})
      : assert(roleRequest != null);

  @override
  String toString() {
    return 'FetchRoleTypeListEvent{roleRequestId: ${roleRequest.id}';
  }
}
