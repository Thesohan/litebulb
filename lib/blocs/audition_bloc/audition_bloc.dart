import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/applied_audition_by_artist_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/applied_audition_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/applied_audition_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/audition_repository/audition_repository.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/util/id_name_converter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AuditionBloc extends BaseBloc<AuditionEvent> {
  AuditionBloc({AuditionRepository auditionRepository})
      : _auditionRepository = auditionRepository ??
            kiwi.Container().resolve<AuditionRepository>() {
    init();
  }
  final AuditionRepository _auditionRepository;
  SharedPreferences _sharedPreferences;

  final Logger _logger = Logger('AuditionBloc');
  final BehaviorSubject<Resource<AuditionListResponse>>
      _auditionListBehaviourSubject =
      BehaviorSubject<Resource<AuditionListResponse>>();

  Observable<Resource<AuditionListResponse>>
      get auditionListBehaviourObservable =>
          _auditionListBehaviourSubject.stream;

  final BehaviorSubject<String> _categoryBehaviourSubject =
      BehaviorSubject<String>();

  Observable<String> get categoryBehaviourObservable =>
      _categoryBehaviourSubject.stream;

  final BehaviorSubject<String> _subCategoryBehaviourSubject =
      BehaviorSubject<String>();

  Observable<String> get subCategoryBehaviourObservable =>
      _subCategoryBehaviourSubject.stream;

  final BehaviorSubject<String> _roleNameBehaviourSubject =
      BehaviorSubject<String>();

  Observable<String> get roleNameBehaviourObservable =>
      _roleNameBehaviourSubject.stream;

  /// There are many kinds of subjects. For this specific requirement, a PublishSubject works
  /// well because we wish to continue the sequence from where it left off. So assuming events 1,2,3
  /// were emitted in (B), after (A) connects back we only want to see 4, 5, 6.
  /// If we used a ReplaySubject we would see [1, 2, 3], 4, 5, 6; or if we used a BehaviorSubject
  /// we would see 3, 4, 5, 6 etc.
  final PublishSubject<Resource<AuditionListResponse>>
      _activeAuditionBehaviourSubject =
      PublishSubject<Resource<AuditionListResponse>>();

  Observable<Resource<AuditionListResponse>>
      get activeAuditionBehaviourObservable =>
          _activeAuditionBehaviourSubject.stream;

  final BehaviorSubject<Resource<AuditionListResponse>>
      _inActiveAuditionBehaviourSubject =
      BehaviorSubject<Resource<AuditionListResponse>>();

  Observable<Resource<AuditionListResponse>>
      get inActiveAuditionBehaviourObservable =>
          _inActiveAuditionBehaviourSubject.stream;

  final BehaviorSubject<Resource<List<AppliedAuditionModel>>>
      _appliedAuditionResponseBehaviourSubject =
      BehaviorSubject<Resource<List<AppliedAuditionModel>>>();

  Observable<Resource<List<AppliedAuditionModel>>>
      get appliedAuditionResponseBehaviourObservable =>
          _appliedAuditionResponseBehaviourSubject.stream;

  final BehaviorSubject<Resource<List<AuditionResponse>>>
      _artistWishlistResponseBehaviourSubject =
      BehaviorSubject<Resource<List<AuditionResponse>>>();

  Observable<Resource<List<AuditionResponse>>>
      get artistWishlistResponseObservable =>
          _artistWishlistResponseBehaviourSubject.stream;


  final BehaviorSubject<Resource<AgencyProfileResponse>>
  _agencyProfileResponseBehaviourSubject =
  BehaviorSubject<Resource<AgencyProfileResponse>>();

  Observable<Resource<AgencyProfileResponse>>
  get agencyProfileResponseObservable =>
      _agencyProfileResponseBehaviourSubject.stream;



  void handleEvent(AuditionEvent event) {
    if (event is FetchFeaturedAuditionBlocEvent) {
      _fetchFeaturedAudition(event);
    } else if (event is FetchCategoryEvent) {
      _getCategory(event);
    } else if (event is GetRolesEvent) {
      _getRoles(event);
    } else if (event is FetchAgencyAuditionEvent) {
      _fetchAgencyAudition(event);
    } else if (event is FetchSubCategoryEvent) {
      _getSubCategory(event);
    } else if (event is ApplyAuditionEvent) {
      _applyAudition(event);
    } else if (event is AddToWishlistEvent) {
      _addToWishlist(event);
    } else if (event is LaunchUrlEvent) {
      _launchUrl(event);
    } else if (event is FetchAppliedAuditionEvent) {
      _fetchAppliedAuditions();
    } else if (event is FetchWishlistEvent) {
      _fetchWishlist();
    }
    else if(event is FetchAuditionAgencyDetailsEvent){
      _fetchAuditionAgencyDetails(event);
    }
  }

  @override
  void dispose() {
    _auditionListBehaviourSubject.close();
    _categoryBehaviourSubject.close();
    _roleNameBehaviourSubject.close();
    _activeAuditionBehaviourSubject.close();
    _inActiveAuditionBehaviourSubject.close();
    _subCategoryBehaviourSubject.close();
    _appliedAuditionResponseBehaviourSubject.close();
    _artistWishlistResponseBehaviourSubject.close();
    _agencyProfileResponseBehaviourSubject.close();
    super.dispose();
  }

  void _fetchFeaturedAudition(FetchFeaturedAuditionBlocEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =await sharedPrefHandler.getArtistBio();
    AuditionRequest auditionRequest = event.auditionRequest;
    if(artistProfileResponse!=null){
      auditionRequest = auditionRequest.copyWith(userId: artistProfileResponse.id);
    }
    _auditionListBehaviourSubject.add(null);
    _auditionRepository
        .fetchFeaturedAudition(auditionRequest)
        .listen((Resource<AuditionListResponse> res) async {
      if (res.data != null && res.data.data != null) {
//        List<AuditionResponse> auditionList = res.data.data;
//        List<AuditionResponse> showAuditionList = [];
//        if (auditionList != null) {
//          for (int i = 0; i < auditionList.length; i++) {
//            if (auditionList[i].visibility == '0' ||
//                auditionList[i].status != 'Active') {
//              continue;
//            }
//            bool isValid = DateTime.now()
//                    .difference(
//                      DateTime.parse(auditionList[i].validity),
//                    )
//                    .inDays <
//                0;
//            if (isValid) {
//              showAuditionList.add(auditionList[i]);
//            }
//          }
//          showAuditionList =
//              await _removeAppliedAndWishlistAuditions(showAuditionList, event);
//          res = res.copyWithNewData(data: res.data.copyWith(showAuditionList));
          _auditionListBehaviourSubject.add(res);
//        }
      }
    });
  }

  void _getCategory(FetchCategoryEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    List<CategoryModel> categories = await sharedPrefHandler.getCategoryList();
    String categoryName = IdNameConverter(categoryList: categories)
        .getCategoryNameFromId(categoryId: event.id);
    _categoryBehaviourSubject.add(categoryName);
  }

  void _getRoles(GetRolesEvent event) async {
    String roleName =
        await IdNameConverter().getRoleNameFromId(roleId: event.id);
    _roleNameBehaviourSubject.add(roleName);
  }

  void _fetchAgencyAudition(FetchAgencyAuditionEvent event) async {
    /// removing previous values from the stream so that loading widget can be shown to user.
    _inActiveAuditionBehaviourSubject.add(null);
    _activeAuditionBehaviourSubject.add(null);

    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =await sharedPrefHandler.getArtistBio();
    AuditionRequest auditionRequest = event.auditionRequest;
    if(artistProfileResponse!=null){
      auditionRequest = auditionRequest.copyWith(userId: artistProfileResponse.id);
    }
    _logger.info("audition request ${auditionRequest.agency_id}, ${auditionRequest.user_id}, ${auditionRequest.is_featured}");
    Resource<AuditionListResponse> res = await _auditionRepository
        .fetchAgencyAudition(event.auditionRequest)
        .last;
    if (res.data != null && res.data.data != null) {
      List<AuditionResponse> auditionList = res.data.data;
      if (auditionList != null) {
        List<AuditionResponse> activeAuditions = [];
        List<AuditionResponse> inactiveAuditions = [];
        for (int i = 0; i < auditionList.length; i++) {
          if (auditionList[i].visibility == '0' ||
              auditionList[i].status != 'Active') {
            continue;
          }
          bool isValid = DateTime.now()
                  .difference(
                    DateTime.parse(auditionList[i].validity),
                  )
                  .inDays <
              0;
          if (isValid) {
            activeAuditions.add(auditionList[i]);
          } else {
            inactiveAuditions.add(auditionList[i]);
          }
        }
//        ArtistProfileResponse artistProfileResponse = _getArtistBio();
//        FetchFeaturedAuditionBlocEvent featuredAuditionBlocEvent =
//            FetchFeaturedAuditionBlocEvent(
//          auditionRequest: AuditionRequest(
//            agency_id: event.auditionRequest.agency_idz,
//            user_id: artistProfileResponse.id,
//            is_featured: '1',
//          ),
//        );
//        activeAuditions = await _removeAppliedAndWishlistAuditions(
//            activeAuditions, featuredAuditionBlocEvent);
//        inactiveAuditions = await _removeAppliedAndWishlistAuditions(
//            inactiveAuditions, featuredAuditionBlocEvent);

        _activeAuditionBehaviourSubject.add(
          res.copyWithNewData(
            data: res.data.copyWith(activeAuditions),
          ),
        );
        _inActiveAuditionBehaviourSubject.add(
          res.copyWithNewData(
            data: res.data.copyWith(inactiveAuditions),
          ),
        );
      }
    }
  }

  void _getSubCategory(FetchSubCategoryEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    List<CategoryModel> subCategories =
        await sharedPrefHandler.getSubCategoryList();
    String categoryName = IdNameConverter(categoryList: subCategories)
        .getCategoryNameFromId(categoryId: event.id);
    _logger.info('subcategory****$categoryName}');
    if (categoryName.isNotEmpty) {
      _subCategoryBehaviourSubject.add(categoryName);
    }
  }

  void _applyAudition(ApplyAuditionEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      event.appliedAuditionRequest.copyWith(artistid: artistProfileResponse.id);
      _auditionRepository
          .applyAudition(event.appliedAuditionRequest)
          .listen((Resource<SimpleMessageResponse> res) {
        if (res != null && res.data != null) {
          event.completer.complete(res.data.message);
        }
      });
    }
  }

  void _launchUrl(LaunchUrlEvent event) async {
    final String url = "https://${event.url}";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _addToWishlist(AddToWishlistEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      event = event.copyWith(
          addToWishlistRequest: event.addToWishlistRequest
              .copyWith(artistid: artistProfileResponse.id));
      _logger.info(
          "artistId:${artistProfileResponse.id},postid${event.addToWishlistRequest.postid},agency${event.addToWishlistRequest.agencyid}");

      _auditionRepository
          .addToWishlist(event.addToWishlistRequest)
          .listen((Resource<SimpleMessageResponse> res) {
        if (res != null && res.data != null) {
          event.completer.complete(res.data.message);
        }
      });
    }
  }

  void _fetchAppliedAuditions() async {
    _appliedAuditionResponseBehaviourSubject.add(null);
    ArtistProfileResponse artistProfileResponse =await _getArtistBio();
    if (artistProfileResponse != null) {
      Resource<AppliedAuditionResponse> res = await _auditionRepository
          .fetchAppliedAudition(
            AppliedAuditionByArtistRequest(
                artistid: artistProfileResponse.id, status: "All"),
          )
          .last;
      if (res != null && res.data != null && res.data.data != null) {
        List<AppliedAuditionModel> appliedAuditionModels = res.data.data;
        Resource<List<AppliedAuditionModel>> updatedRes = Resource(
            data: appliedAuditionModels,
            message: res.message,
            status: res.status);
        _appliedAuditionResponseBehaviourSubject.add(updatedRes);
      }
    }
  }

  Future<ArtistProfileResponse> _getArtistBio() async{
    SharedPrefHandler sharedPrefHandler  = SharedPrefHandler();
   ArtistProfileResponse artistProfileResponse= await sharedPrefHandler.getArtistBio();
   return artistProfileResponse;
  }

  void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void _fetchWishlist() async {
    _artistWishlistResponseBehaviourSubject.add(null);
    ArtistProfileResponse artistProfileResponse =await _getArtistBio();
    if (artistProfileResponse != null) {
      ArtistIdRequest artistWishlistRequest =
          ArtistIdRequest(artistid: artistProfileResponse.id);
      _logger.info("bio******${artistProfileResponse.id}");
      Resource<ArtistWishlistResponse> artistWishlistResponseResource =
          await _auditionRepository.fetchWishlist(artistWishlistRequest).last;
      if (artistWishlistResponseResource != null &&
          artistWishlistResponseResource.data != null) {
        SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
        await sharedPrefHandler
            .setArtistWishlist(artistWishlistResponseResource.data);
        List<AuditionResponse> auditionResponseList = [];
        artistWishlistResponseResource.data.data.forEach((wishlistModel) {
          auditionResponseList.add(wishlistModel.auditionDetails);
        });
        Resource<List<AuditionResponse>> res = Resource(
          data: auditionResponseList,
          message: artistWishlistResponseResource.message,
          status: artistWishlistResponseResource.status,
        );
        _artistWishlistResponseBehaviourSubject.add(res);
      }
    }
  }

  Future<List<AuditionResponse>> _removeAppliedAndWishlistAuditions(
      List<AuditionResponse> showAuditionList,
      FetchFeaturedAuditionBlocEvent event) async {
    Resource<ArtistWishlistResponse> artistWishlistResponseResource =
        await _auditionRepository
            .fetchWishlist(
              ArtistIdRequest(artistid: event.auditionRequest.user_id),
            )
            .last;

    Resource<AppliedAuditionResponse> appliedAuditionResponse =
        await _auditionRepository
            .fetchAppliedAudition(
              AppliedAuditionByArtistRequest(
                  artistid: event.auditionRequest.user_id),
            )
            .last;

    /// Removing auditions present in wishlist
    artistWishlistResponseResource?.data?.data?.forEach((wishlistModel) {
      showAuditionList.removeWhere(
          (audition) => audition.id == wishlistModel.auditionDetails.id);
    });
    appliedAuditionResponse?.data?.data?.forEach((wishlistModel) {
      showAuditionList.removeWhere(
          (audition) => audition.id == wishlistModel.auditionDetails.id);
    });
    return showAuditionList;
  }

  void _fetchAuditionAgencyDetails(FetchAuditionAgencyDetailsEvent event) async{
  Resource<AgencyProfileResponse> res =await  _auditionRepository.fetchAgencyProfile(AgencyProfileRequest(username: event.username)).last;
  if(res!=null && res.data!=null){
    _agencyProfileResponseBehaviourSubject.add(res);
    event.completer.complete(res.data);
  }
  }
}
