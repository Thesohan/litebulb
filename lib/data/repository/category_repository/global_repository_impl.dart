import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/role_list_response.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/category_repository/global_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class CategoryRepositoryImpl implements GlobalRepository {
  final Logger _logger = Logger("CategoryRepositoryImpl");
  final NetworkService networkService;

  CategoryRepositoryImpl({@required this.networkService})
      : assert(networkService != null);
  @override
  Stream<Resource<CategoryModelResponse>> fetchCategory(
      IdRequest categoryRequest) async* {
    assert(categoryRequest != null);
    yield Resource.loading();
    yield await networkService.globalApi
        .fetchCategory(categoryRequest: categoryRequest);
  }

  @override
  Stream<Resource<RoleListResponse>> fetchRoles(IdRequest roleRequest) async* {
    assert(roleRequest != null);
    yield Resource.loading();
    yield await networkService.globalApi.fetchRoles(roleRequest: roleRequest);
  }
}
