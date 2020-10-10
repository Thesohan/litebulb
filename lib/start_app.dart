import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/di/injector.dart';
import 'package:new_artist_project/ui/pages/home/homePage.dart';
import 'dart:async';
import 'package:new_artist_project/ui/pages/login_page.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'blocs/all_artist_bloc/all_artist_bloc.dart';
import 'blocs/audition_bloc/audition_bloc.dart';
import 'constants/imageAssets.dart';
import 'constants/spaces.dart';
import 'routes/routes.dart';

void startApp() async {
  Routes.initRoutes();
  Injector.setup();
  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
  runApp(
    MaterialApp(
      home: MyApp(),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorObservers: [
        SailorLoggingObserver(),
      ],
      navigatorKey: Routes.sailor.navigatorKey,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.pink,
        fontFamily: AppConstants.MONTSERRAT,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) async {
      if(token!=null){
        SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
        sharedPrefHandler.setDeviceToken(token);
      }
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message){
        print('on message \n**************************************************************\n\n\n\n$message');
        Routes.navigate(Routes.CHAT_DETAILS_PAGE,params: {'data':'$message +onMessage'});
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume  \**************************************************************\n\n\n\n $message');
        Routes.navigate(Routes.CHAT_DETAILS_PAGE,params: {'data':'$message +onResume'});
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch  \**************************************************************\n\n\n\n $message');
        Routes.navigate(Routes.CHAT_DETAILS_PAGE,params: {'data':'$message +onLaunch'});
      },
    );


    Future.delayed(
        Duration(
          seconds: 3,
        ), () async {
      bool isTokenSaved = await _isOAuthTokenSaved();
      if (await _isOAuthTokenSaved()) {
        _replacePage();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>MultiProvider(
              providers: [
                Provider<GlobalBloc>(
                  create: (context)=>GlobalBloc(),
                  dispose: (context,bloc)=>bloc.dispose(),
                ),
                Provider<AuthenticationBloc>(
                  create: (context) => AuthenticationBloc(),
                  dispose: (context, bloc) => bloc.dispose(),
                ),
              ],  child: LoginPage(),
            ),

          ),
        );
      }
    });
  }
  void _replacePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            Provider<AllArtistBloc>(
              create: (context) => AllArtistBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AuditionBloc>(
              create: (context) => AuditionBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AgencyProfileBloc>(
              create: (context) => AgencyProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<GlobalBloc>(
              create: (context) => GlobalBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<ArtistProfileBloc>(
              create: (context) => ArtistProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<VideoBloc>(
              create: (context) => VideoBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(ImageAssets.APPICON),
              radius: 80,
            ),
            Spaces.h20,
            SpinKitFadingCircle(
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _isOAuthTokenSaved() async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    String token = await sharedPrefHandler.getOAuthToken();
    if (token != null) {
      return true;
    }
    return false;
  }
}
