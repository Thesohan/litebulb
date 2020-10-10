import 'package:new_artist_project/data/models/api/request/artist_category_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/resource.dart';

abstract class AllArtistInfoRepository {
  Stream<Resource<AllArtistInfoResponse>> fetchArtistProfile(
    ArtistCategoryRequest allArtistInfoId,
  );
}
