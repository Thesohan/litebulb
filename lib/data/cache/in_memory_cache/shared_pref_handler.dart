import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_wishlist_response.dart';
import 'package:new_artist_project/data/models/api/response/category_model_response.dart';
import 'package:new_artist_project/data/models/api/response/role_list_response.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/models/role_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHandler {
  // ignore: non_constant_identifier_names
        "artist_bio_memory_cache_key";
  // ignore: non_constant_identifier_names
  static final String ARTIST_EXPERIENCE_CACHE_KEY =
      "artist_exp_memory_cache_key";
  static final String OTHER_ARTIST_EXPERIENCE_CACHE_KEY =
      "other_artist_exp_memory_cache_key";
  // ignore: non_constant_identifier_names
  static final String ARTIST_CREDIT_CACHE_KEY = "artist_cred_memory_cache_key";

  static final String OTHER_ARTIST_CREDIT_CACHE_KEY =
      "other_artist_cred_memory_cache_key";
  // ignore: non_constant_identifier_names
  static final String CATEGORY_CACHE_KEY = "category_cache_key";
  static final String SUB_CATEGORY_CACHE_KEY = "sub_category_cache_key";
  static final String ROLE_TYPE_RESPONSE = "role_type_list";
  static final String ARTIST_WISHLIST_RESPONSE_CACHE_KEY =
      "artist_wishlist_response_cache_key";
  static final String  COOKIES_CACHE_KEY = "cookies_cache_key";
  static final String ARTIST_OAUTH_TOKEN_CACHE_KEY =
      "artist_oauth_token_cache_key";
  static final String DEVICE_TOKEN = "device_token";

  Future<ArtistProfileResponse> getArtistBio() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString =
        sharedPreferences.getString(ARTIST_BIO_MEMORY_CACHE_KEY);
    if (jsonString != null) {
     Map<String,dynamic> finalJson = json.decode(jsonString);
     if(finalJson!=null){
       ArtistProfileResponse artistProfileResponse =
       ArtistProfileResponse.fromJson(finalJson);
       return artistProfileResponse;
     }
    }
    return null;
  }

  Future setArtistBio(ArtistProfileResponse artistProfileResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        ARTIST_BIO_MEMORY_CACHE_KEY, json.encode(artistProfileResponse));
  }

  Future deleteArtistBio()async{
    SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
    sharedPreferences.remove(ARTIST_BIO_MEMORY_CACHE_KEY);
  }

  Future setOAuthToken(String oAuthToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(ARTIST_OAUTH_TOKEN_CACHE_KEY, oAuthToken);
  }

  Future<String> getOAuthToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String string =
    sharedPreferences.getString(SharedPrefHandler.ARTIST_OAUTH_TOKEN_CACHE_KEY);
    return string;
  }

  Future deleteAuthToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPrefHandler.ARTIST_OAUTH_TOKEN_CACHE_KEY);
  }



  Future<List<CategoryModel>> getCategoryList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<CategoryModel> categoryList = [];
    String jsonString =
        sharedPreferences.getString(SharedPrefHandler.CATEGORY_CACHE_KEY);
    if (jsonString != null) {
      Map<String, dynamic> categories = json.decode(jsonString);
      if (categories != null) {
        CategoryModelResponse categoryModelResponse =
            CategoryModelResponse.fromJson(categories);
        categoryList = categoryModelResponse.data;
      }
    }
    return categoryList;
  }

  Future<List<CategoryModel>> getSubCategoryList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<CategoryModel> categoryList = [];
    String jsonString =
        sharedPreferences.getString(SharedPrefHandler.SUB_CATEGORY_CACHE_KEY);
    if (jsonString != null) {
      Map<String, dynamic> categories = json.decode(jsonString);
      if (categories != null) {
        CategoryModelResponse categoryModelResponse =
            CategoryModelResponse.fromJson(categories);
        categoryList = categoryModelResponse.data;
      }
    }
    return categoryList;
  }

  Future<List<RoleModel>> getRoleList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<RoleModel> roleList = [];

    String jsonString =
        sharedPreferences.getString(SharedPrefHandler.ROLE_TYPE_RESPONSE);
    if (jsonString != null) {
      Map<String, dynamic> roles = json.decode(jsonString);
      if (roles != null) {
        RoleListResponse roleListResponse = RoleListResponse.fromJson(roles);
        roleList = roleListResponse.data;
      }
    }
    return roleList;
  }

  Future setArtistWishlist(
      ArtistWishlistResponse artistWishlistResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      ARTIST_WISHLIST_RESPONSE_CACHE_KEY,
      json.encode(artistWishlistResponse),
    );
  }

  Future setArtistExperience(ExpOrProResponse expOrProResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      SharedPrefHandler.ARTIST_EXPERIENCE_CACHE_KEY,
      json.encode(expOrProResponse),
    );
  }

  Future setOtherArtistExperience(ExpOrProResponse expOrProResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      SharedPrefHandler.OTHER_ARTIST_EXPERIENCE_CACHE_KEY,
      json.encode(expOrProResponse),
    );
  }

  Future setArtistCredits(CredResponse credResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      SharedPrefHandler.ARTIST_CREDIT_CACHE_KEY,
      json.encode(credResponse),
    );
  }

  Future setOtherArtistCredits(CredResponse credResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      SharedPrefHandler.OTHER_ARTIST_CREDIT_CACHE_KEY,
      json.encode(credResponse),
    );
  }

  Future updateCookies(Headers headers)async{
    String rawCookie = headers.value('Set-Cookie');
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    if(rawCookie!=null){
      sharedPreferences.setString(COOKIES_CACHE_KEY,rawCookie);
    }
  }

  Future getCookies()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String rawCookie = sharedPreferences.get(COOKIES_CACHE_KEY);
    return rawCookie;
  }

  Future getDeviceToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(DEVICE_TOKEN);
  }
  Future setDeviceToken(String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(DEVICE_TOKEN,token);
  }

}
