import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/data/models/api/request/artist_category_request.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/network/request_handler.dart';
import 'package:new_artist_project/data/resource.dart';

class AllArtistInfoApi {
  final RequestHandler _requestHandler;
  final Logger _logger = Logger('AllArtistInfoApi');

  AllArtistInfoApi(this._requestHandler) : assert(_requestHandler != null);

  Future<Resource<AllArtistInfoResponse>> fetchAllArtistInfo({
    @required ArtistCategoryRequest allArtistInfoRequestBody,
  }) async {
    assert(allArtistInfoRequestBody != null);
    return _requestHandler.sendRequest(
      method: Method.post,
      body: allArtistInfoRequestBody.toJson(),
      path: "/BrowseArtist_controller/index_post",
      responseMapper: (data) => AllArtistInfoResponse.fromJson(data.data),
    );
  }
}
