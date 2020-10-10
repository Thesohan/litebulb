import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/category_model.dart';

class CategoryArtistsModel {
  final List<CategoryModel> categories;
  final AllArtistInfoResponse allArtistInfoResponse;

  CategoryArtistsModel({this.categories, this.allArtistInfoResponse});
}
