import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc_event.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/request/artist_category_request.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/category_Artists_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/all_artist_info_repository/all_artist_info_repository.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:shared_preferences/shared_preferences.dart';

class AllArtistBloc extends BaseBloc<FetchAllArtistEvent> {
  AllArtistBloc({AllArtistInfoRepository allArtistInfoRepository})
      : _allArtistInfoRepository = allArtistInfoRepository ??
            kiwi.Container().resolve<AllArtistInfoRepository>() {
    _init();
  }

  final Logger _logger = Logger("AllArtistBloc");
  SharedPreferences _sharedPreferences;
  final AllArtistInfoRepository _allArtistInfoRepository;
  final BehaviorSubject<Resource<CategoryArtistsModel>>
      _allArtistInfoBehaviorSubject =
      BehaviorSubject<Resource<CategoryArtistsModel>>();

  Observable<Resource<CategoryArtistsModel>> get allArtistInfoObservable =>
      _allArtistInfoBehaviorSubject.stream;

  @override
  void handleEvent(BaseEvent event) {
    if (event is FetchAllArtistEvent) {
      _allArtistInfoBehaviorSubject.add(null);
      _fetchAllArtistInfo();
    }
  }

  @override
  void dispose() {
    _allArtistInfoBehaviorSubject.close();
    super.dispose();
  }

  void _fetchAllArtistInfo() async {
    _allArtistInfoBehaviorSubject.add(null);
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      Resource<AllArtistInfoResponse> allArtistInfoResponse =
          await _allArtistInfoRepository
              .fetchArtistProfile(
                ArtistCategoryRequest(
                  category: 'All',
                  user_id: artistProfileResponse.id,
                ),
              )
              .last;

     /*
//      String value =
//          _sharedPreferences.get(SharedPrefHandler.ARTIST_BIO_MEMORY_CACHE_KEY);
//      if (value != null) {
//        Map<String, dynamic> currentArtistProfileResJson = json.decode(value);
//        if (currentArtistProfileResJson != null) {
//          ArtistProfileResponse currentArtistProfileResponse =
//              ArtistProfileResponse.fromJson(currentArtistProfileResJson);
//          AllArtistInfoResponse updatedAllArtistInfoRes = AllArtistInfoResponse(
//            data: _removedLoggedInArtist(
//              allArtistInfoResponse?.data?.data,
//              currentArtistProfileResponse,
//            ),
//          );
//          allArtistInfoResponse = allArtistInfoResponse.copyWithNewData(
//            data: updatedAllArtistInfoRes,
//          );
//        }
//      }
      */

      List<CategoryModel> categories = await _getCategories();
      Resource<CategoryArtistsModel> categoryArtistRes = Resource.success(
        data: CategoryArtistsModel(
          categories: categories,
          allArtistInfoResponse: allArtistInfoResponse.data,
        ),
      );
      _allArtistInfoBehaviorSubject.add(categoryArtistRes);
    }
  }

  Future<List<CategoryModel>> _getCategories() async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    List<CategoryModel> categories = await sharedPrefHandler.getCategoryList();
    _logger.info('get categories:${categories}');
    return categories;
  }

  void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

//  List<ArtistProfileResponse> _removedLoggedInArtist(
//    List<ArtistProfileResponse> data,
//    ArtistProfileResponse currentArtistProfileResponse,
//  ) {
//    if (data != null) {
//      for (int i = 0; i < data.length; i++) {
//        if (data[i].id == currentArtistProfileResponse.id) {
//          data.removeAt(i);
//          break;
//        }
//      }
//    }
//    return data;
//  }
}
