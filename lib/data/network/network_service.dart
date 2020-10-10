import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:new_artist_project/app_config.dart';
import 'package:new_artist_project/data/network/api/all_agency_profile_api.dart';
import 'package:new_artist_project/data/network/api/all_artist_info_api.dart';
import 'package:new_artist_project/data/network/api/artist_profile_api.dart';
import 'package:new_artist_project/data/network/api/audition_api.dart';
import 'package:new_artist_project/data/network/api/global_api.dart';
import 'package:new_artist_project/data/network/api/login_api.dart';
import 'package:new_artist_project/data/network/api/video_api.dart';
import 'package:new_artist_project/data/network/request_handler.dart';

import 'api/artist_profile_api.dart';

/// Handles networking throughout the application.
class NetworkService {
  factory NetworkService.development() {
    return NetworkService._(shouldLog: true);
  }

  factory NetworkService.production() {
    return NetworkService._(shouldLog: false);
  }
  // Should network requests be logged
  final bool shouldLog;

  // Initialize dio
  final Dio _dio;

  AuthenticationApi _loginApi;
  ArtistProfileApi _artistProfileApi;
  GlobalApi _globalApi;
  AllArtistInfoApi _allArtistInfoApi;
  AuditionApi _auditionApi;
  AllAgencyProfileApi _allAgencyProfileApi;
  VideoApi _videoApi;

  /// Only get is allowed to prevent any change from outside [NetworkService],
  /// and allow just read access to the variable.
  AuthenticationApi get loginApi => _loginApi;

  ArtistProfileApi get artistProfileApi => _artistProfileApi;
  GlobalApi get globalApi => _globalApi;
  AllArtistInfoApi get allArtistInfoApi => _allArtistInfoApi;
  AuditionApi get auditionApi => _auditionApi;
  AllAgencyProfileApi get allAgencyProfileApi => _allAgencyProfileApi;
  VideoApi get videoApi => _videoApi;

  Map<String,String>cookies = {};
  NetworkService._({
    this.shouldLog = false,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            headers: {
              'Content-Type': 'application/json',
            },
            connectTimeout: 3000000,
            receiveTimeout: 3000000,
          ),
        ) {
    // Send request regardless the ssl certificate of the website.
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };

    // Move json decoding to a different isolate
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        (text) => compute(_parseAndDecode, text);

    RequestHandler.init(_dio);
    final RequestHandler requestHandler = RequestHandler.instance;


    // Set up all the API's
    _loginApi = AuthenticationApi(requestHandler);
    _artistProfileApi = ArtistProfileApi(requestHandler);
    _globalApi = GlobalApi(requestHandler);
    _allArtistInfoApi = AllArtistInfoApi(requestHandler);
    _auditionApi = AuditionApi(requestHandler);
    _allAgencyProfileApi = AllAgencyProfileApi(requestHandler);
    _videoApi = VideoApi(requestHandler);
  }

  /// Update the Token Interceptor with new token
  updateToken(String token) {
//    _tokenInterceptor.updateToken(token);
  }
}
_parseAndDecode(String response) {
  return jsonDecode(response);
}
