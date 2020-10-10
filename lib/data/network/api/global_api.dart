import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/role_list_response.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class GlobalApi {
  final RequestHandler _requestHandler;
  final Logger _logger = Logger('CategoryApi');

  GlobalApi(this._requestHandler) : assert(_requestHandler != null);

  Future<Resource<CategoryModelResponse>> fetchCategory({
    @required IdRequest categoryRequest,
  }) async {
    assert(categoryRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: categoryRequest.toJson(),
      path: "/Getcategory_controller/index_post",
      responseMapper: (data) => CategoryModelResponse.fromJson(data.data),
    );
  }

  Future<Resource<RoleListResponse>> fetchRoles({
    @required IdRequest roleRequest,
  }) async {
    assert(roleRequest != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: roleRequest.toJson(),
      path: "/Getrole_controller/index_post",
      responseMapper: (data) => RoleListResponse.fromJson(data.data),
    );
  }
}
