import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/artist_category_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/all_artist_info_repository/all_artist_info_repository.dart';
import 'package:new_artist_project/data/resource.dart';

class AllArtistInfoRepositoryImpl extends AllArtistInfoRepository {
  final NetworkService networkService;
  final Logger _logger = Logger("AllArtistInfoRepositoryInfo");
  AllArtistInfoRepositoryImpl({@required this.networkService})
      : assert(networkService != null);

  @override
  Stream<Resource<AllArtistInfoResponse>> fetchArtistProfile(
      ArtistCategoryRequest allArtistInfoId) async* {
    assert(allArtistInfoId != null);
    yield Resource.loading();
    yield await this
        .networkService
        .allArtistInfoApi
        .fetchAllArtistInfo(allArtistInfoRequestBody: allArtistInfoId);
  }
}
