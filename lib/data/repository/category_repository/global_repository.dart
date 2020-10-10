import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/role_list_response.dart';
import 'package:new_artist_project/data/resource.dart';

abstract class GlobalRepository {
  Stream<Resource<CategoryModelResponse>> fetchCategory(
      IdRequest categoryRequest);
  Stream<Resource<RoleListResponse>> fetchRoles(IdRequest roleRequest);
}
