import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/aritst_bio_bloc_event.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/repository/artist_profile_repository/artist_profile_repository.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/util/id_name_converter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:shared_preferences/shared_preferences.dart';

class ArtistBioBloc extends BaseBloc {
  ArtistBioBloc({ArtistProfileRepository artistProfileRepository})
      : _artistProfileRepository = artistProfileRepository ??
            kiwi.Container().resolve<ArtistProfileRepository>() {
    init();
  }

  SharedPreferences _sharedPreferences;
  final Logger _logger = Logger('ArtistProfileBloc');
  final ArtistProfileRepository _artistProfileRepository;
  final PublishSubject<ArtistProfileResponse>
      _artistProfileResponsePublishSubject =
      PublishSubject<ArtistProfileResponse>();
  Observable<ArtistProfileResponse> get artistProfileResponseObservable =>
      _artistProfileResponsePublishSubject.stream;

  /// Observable for gender
  final BehaviorSubject<String> _genderBehaviourSubject =
      BehaviorSubject<String>();
  Observable<String> get genderObservable => _genderBehaviourSubject.stream;

  /// Observable for language
  Set<String> _languages = Set();
  final BehaviorSubject<Set<String>> _languageBehaviourSubject =
      BehaviorSubject<Set<String>>();
  Observable<Set<String>> get languageObservable =>
      _languageBehaviourSubject.stream;

  /// Observable for skills
  Set<String> _skills = Set();
  final BehaviorSubject<Set<String>> _skillBehaviourSubject =
      BehaviorSubject<Set<String>>();
  Observable<Set<String>> get skillObservable => _skillBehaviourSubject.stream;

  /// Observable for birthday
  final BehaviorSubject<String> _birthdayBehaviourSubject =
      BehaviorSubject<String>();
  Observable<String> get birthdayObservable => _birthdayBehaviourSubject.stream;

  /// Observable for birthday
  final BehaviorSubject<String> _categoryBehaviourSubject =
      BehaviorSubject<String>();
  Observable<String> get categoryObservable => _categoryBehaviourSubject.stream;

  @override
  void handleEvent(BaseEvent event) {
    if (event is ArtistBioUpdateEvent) {
      _updateArtistProfile(event);
    } else if (event is ArtistExperienceUpdateEvent) {
      _updateArtistExperience(event);
    } else if (event is ArtistCreditUpdateEvent) {
      _updateArtistCredit(event);
    } else if (event is UpdateGenderDropDown) {
      _genderBehaviourSubject.add(event.gender);
    } else if (event is UpdateLanguageTags) {
      _languages = event.languages;
      _languageBehaviourSubject.add(event.languages);
    } else if (event is RemoveLanguageTag) {
      _languages.remove(event.language);
      _languageBehaviourSubject.add(_languages);
    } else if (event is AddLanguageTag) {
      _languages.add(event.language);
      _languageBehaviourSubject.add(_languages);
    } else if (event is RemoveSkillTag) {
      _skills.remove(event.skill);
      _skillBehaviourSubject.add(_skills);
    } else if (event is AddSkillTag) {
      _skills.add(event.skill);
      _skillBehaviourSubject.add(_skills);
    } else if (event is UpdateSkillTags) {
      _skills = event.skills;
      _skillBehaviourSubject.add(event.skills);
    } else if (event is UpdateBirthdayEvent) {
      _birthdayBehaviourSubject.add(event.birthday);
    } else if (event is UpdateCategoryEvent) {
      _categoryBehaviourSubject.add(event.category);
    }
  }

  @override
  void dispose() {
    _genderBehaviourSubject.close();
    _artistProfileResponsePublishSubject.close();
    _languageBehaviourSubject.close();
    _skillBehaviourSubject.close();
    _birthdayBehaviourSubject.close();
    _categoryBehaviourSubject.close();
    super.dispose();
  }

  void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _getArtistBio();
    _genderBehaviourSubject.add('Male');
    _languageBehaviourSubject.add(_languages);
    _skillBehaviourSubject.add(_skills);
    _birthdayBehaviourSubject.add('+ Add');
  }

  List<CategoryModel> _getCategoryList() {
    List<CategoryModel> categoryList = [];
    Map<String, dynamic> categories = json.decode(
      _sharedPreferences.getString(SharedPrefHandler.CATEGORY_CACHE_KEY),
    );
    if (categories != null) {
      CategoryModelResponse categoryModelResponse =
          CategoryModelResponse.fromJson(categories);
      categoryList = categoryModelResponse.data;
    }
    return categoryList;
  }

  void _updateArtistProfile(ArtistBioUpdateEvent artistBioUpdateEvent) async {
    final String languages =
        this._languages.fold('', (p, c) => '$c${p != '' ? ',$p' : ''}');
    final String skills =
        this._skills.fold('', (p, c) => '$c${p != '' ? ',$p' : ''}');
    IdNameConverter categoryConverter = IdNameConverter(
      categoryList: _getCategoryList(),
    );
    ArtistProfileResponse artistProfileResponse =
        artistBioUpdateEvent.artistProfileResponse.copyWith(
      language: languages,
      skills: skills,
      birthday: _birthdayBehaviourSubject.value,
      gender: _genderBehaviourSubject.value,
      category: categoryConverter.getCategoryIdFromName(
        name: _categoryBehaviourSubject.value,
      ),
    );
    _logger.info('updateArtistProfile:$artistProfileResponse');
    Resource<SimpleMessageResponse> res = await _artistProfileRepository
        .updateArtistProfile(artistProfileResponse)
        .last;
    artistProfileResponse = artistProfileResponse.copyWith(
      category: categoryConverter.getCategoryNameFromId(
        categoryId: artistProfileResponse.category,
      ),
    );

    if (res != null && res.data.success == 'true') {
      _sharedPreferences.setString(
        SharedPrefHandler.ARTIST_BIO_MEMORY_CACHE_KEY,
        json.encode(artistProfileResponse),
      );
      _artistProfileResponsePublishSubject.add(artistProfileResponse);
      artistBioUpdateEvent.completer.complete(res);
    }
  }

  void _getArtistBio() async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      _artistProfileResponsePublishSubject.add(artistProfileResponse);
    }
  }

  void _updateArtistCredit(ArtistCreditUpdateEvent event) async {
    Resource<SimpleMessageResponse> res = await _artistProfileRepository
        .updateArtistCredit(event.artistCreditModel)
        .last;
    if (res != null && res.data?.success == "true") {
      await _updateCreditList(event.artistCreditModel);
      event.completer.complete(res);
    }
  }

  void _updateArtistExperience(ArtistExperienceUpdateEvent event) async {
    Resource<SimpleMessageResponse> res = await _artistProfileRepository
        .updateArtistExperience(event.artistExperienceModel)
        .last;
    if (res != null && res.data?.success == "true") {
      await _updateExperienceList(event.artistExperienceModel);
      event.completer.complete(res);
    }
  }

  Future _updateExperienceList(ArtistExperienceModel artistExp) async {
    int indexAt = -1;
    Map<String, dynamic> artistExperiences = json.decode(
      _sharedPreferences.get(SharedPrefHandler.ARTIST_EXPERIENCE_CACHE_KEY),
    );
    ExpOrProResponse artistExpOrCredResponse =
        ExpOrProResponse.fromJson(artistExperiences);
    for (int i = 0; i < artistExpOrCredResponse.data.length; i++) {
      if (artistExpOrCredResponse.data[i].p_id == artistExp.p_id) {
        indexAt = i;
      }
    }
    if (indexAt != -1) {
      artistExpOrCredResponse.data.removeAt(indexAt);
    }
    artistExpOrCredResponse.data.add(artistExp);
    _sharedPreferences.remove(SharedPrefHandler.ARTIST_EXPERIENCE_CACHE_KEY);
    _sharedPreferences.setString(
      SharedPrefHandler.ARTIST_EXPERIENCE_CACHE_KEY,
      json.encode(
        artistExpOrCredResponse,
      ),
    );
  }

  Future _updateCreditList(CreditModel artistCreditModel) async {
    int indexAt = -1;
    Map<String, dynamic> artistCredits = json.decode(
      _sharedPreferences.get(SharedPrefHandler.ARTIST_CREDIT_CACHE_KEY),
    );
    CredResponse artistCreditResponse = CredResponse.fromJson(artistCredits);
    for (int i = 0; i < artistCreditResponse.data.length; i++) {
      if (artistCreditResponse.data[i].p_id == artistCreditModel.p_id) {
        indexAt = i;
      }
    }
    if (indexAt != -1) {
      artistCreditResponse.data.removeAt(indexAt);
    }
    artistCreditResponse.data.add(artistCreditModel);
    _sharedPreferences.remove(SharedPrefHandler.ARTIST_CREDIT_CACHE_KEY);
    _sharedPreferences.setString(
      SharedPrefHandler.ARTIST_CREDIT_CACHE_KEY,
      json.encode(
        artistCreditResponse,
      ),
    );
  }
}
