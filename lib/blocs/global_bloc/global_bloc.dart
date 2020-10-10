import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc_event.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/role_list_response.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/category_repository/global_repository.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/artistProfile/artist_bio_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc extends BaseBloc {
  GlobalBloc({GlobalRepository globalRepository})
      : _globalRepository =
            globalRepository ?? kiwi.Container().resolve<GlobalRepository>() {
    init();
  }

  final Logger _logger = Logger('GlobalBloc');
  final GlobalRepository _globalRepository;
  SharedPreferences _sharedPreferences;

  /// Observable for category
  final BehaviorSubject<CategoryListModel> _categoryBehaviourSubject =
      BehaviorSubject<CategoryListModel>();

  Observable<CategoryListModel> get categoryObservable =>
      _categoryBehaviourSubject.stream;

  /// Observable for category
  final BehaviorSubject<List<CategoryModel>> _subCategoryBehaviourSubject =
      BehaviorSubject<List<CategoryModel>>();

  Observable<List<CategoryModel>> get subCategoryObservable =>
      _subCategoryBehaviourSubject.stream;

  @override
  void handleEvent(BaseEvent event) {
    if (event is CategoryBlocEvent) {
      _fetchCategories(event.categoryRequest);
    } else if (event is GetCategoryEvent) {
      _fetchCategoryListFromPref();
    } else if (event is GetSubCategoryEvent) {
      _fetchSubCategoryListFromPref();
    } else if (event is UpdateCategoryDropDownValue) {
      _categoryBehaviourSubject.add(null);
      _categoryBehaviourSubject.add(
        CategoryListModel(
          categoryList: event.categoryListModel.categoryList,
          value: event.categoryListModel.value,
        ),
      );
    } else if (event is FetchRoleTypeListEvent) {
      _fetchAndSaveRoles(event);
    }
  }

  @override
  void dispose() {
    _categoryBehaviourSubject.close();
    _subCategoryBehaviourSubject.close();
    super.dispose();
  }

  /// all categories with parent_id!=0 are subcategories, so remove them
  void _fetchCategories(IdRequest categoryRequest) async {
    Resource<CategoryModelResponse> res =
        await _globalRepository.fetchCategory(categoryRequest).last;
    _logger.info("$res");
    if (res != null && res.data != null && res.data.data.length > 0) {
      CategoryModelResponse categoryModelResponse = res.data;
      List<CategoryModel> subCategories = categoryModelResponse.data
          .where((categoryModel) => categoryModel.parent_id != "0")
          .toList();
      categoryModelResponse.data
          .removeWhere((categoryModel) => categoryModel.parent_id != '0');
      _sharedPreferences.setString(
        SharedPrefHandler.CATEGORY_CACHE_KEY,
        json.encode(res.data),
      );

      /// Saving subcategories
      CategoryModelResponse catModRes = CategoryModelResponse(
          data: subCategories,
          success: categoryModelResponse.success,
          message: categoryModelResponse.message);
      _sharedPreferences.setString(
        SharedPrefHandler.SUB_CATEGORY_CACHE_KEY,
        json.encode(catModRes),
      );
      catModRes.data.forEach((d) => _logger.info('subcategories:${d.name}'));
//      _logger.info('subcategories${categoryModelResponse.data}')
    }
    dispatch(GetCategoryEvent());
  }

 Future<ArtistProfileResponse> _getArtistBio() async{
   SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
   ArtistProfileResponse artistProfileResponse = await sharedPrefHandler.getArtistBio();
   return artistProfileResponse;
  }

  void _fetchCategoryListFromPref() async{
    List<CategoryModel> categoryList = _getCategoryList();
    ArtistProfileResponse artistProfileResponse =await _getArtistBio();
    if ( artistProfileResponse != null && artistProfileResponse.category!=null && artistProfileResponse.category.trim()!="") {
      _categoryBehaviourSubject.add(
        CategoryListModel(
          categoryList: categoryList,
          value: artistProfileResponse.category,
        ),
      );
    }
    else if(categoryList.length>0){
      _categoryBehaviourSubject.add(
        CategoryListModel(
          categoryList: categoryList,
          value: categoryList[0].name,
        ),
      );
    }
  }

  void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  List<CategoryModel> _getCategoryList() {
    List<CategoryModel> categoryList = [];
    String stringJson =
        _sharedPreferences.getString(SharedPrefHandler.CATEGORY_CACHE_KEY);
    if (stringJson != null) {
      CategoryModelResponse categoryModelResponse =
          CategoryModelResponse.fromJson(json.decode(stringJson));
      categoryList = categoryModelResponse.data;
    }
    return categoryList;
  }

  void _fetchAndSaveRoles(FetchRoleTypeListEvent event) {
    _globalRepository
        .fetchRoles(event.roleRequest)
        .listen((Resource<RoleListResponse> res) async {
      if (res != null && res.data != null && res.data.data.length > 0) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
          SharedPrefHandler.ROLE_TYPE_RESPONSE,
          json.encode(res.data),
        );
        _logger.info('roles fetched :${res.data.data}');
      }
    });
  }

  void _fetchSubCategoryListFromPref() {
    List<CategoryModel> categoryList = _getSubCategoryList();
    if (categoryList != null) {
      _subCategoryBehaviourSubject.add(categoryList);
    }
  }

  List<CategoryModel> _getSubCategoryList() {
    List<CategoryModel> categoryList = [];
    String stringJson =
        _sharedPreferences.getString(SharedPrefHandler.SUB_CATEGORY_CACHE_KEY);
    if (stringJson != null) {
      CategoryModelResponse categoryModelResponse =
          CategoryModelResponse.fromJson(json.decode(stringJson));
      categoryList = categoryModelResponse.data;
    }
    return categoryList;
  }
}
