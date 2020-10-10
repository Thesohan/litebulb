import 'dart:async';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/artist_bio_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/ui/agencyProfile/agencyProfilePage.dart';
import 'package:new_artist_project/ui/artistProfile/add_credits_page.dart';
import 'package:new_artist_project/ui/artistProfile/add_experience_page.dart';
import 'package:new_artist_project/ui/artistProfile/artist_profile_page.dart';
import 'package:new_artist_project/ui/artistProfile/add_artist_bio_page.dart';
import 'package:new_artist_project/ui/pages/artists_page.dart';
import 'package:new_artist_project/ui/pages/audition_detail_page.dart';
import 'package:new_artist_project/ui/pages/audition_tracking_page.dart';
import 'package:new_artist_project/ui/pages/blocked_agency_page.dart';
import 'package:new_artist_project/ui/pages/chat_details_page.dart';
import 'package:new_artist_project/ui/pages/comment_replies.dart';
import 'package:new_artist_project/ui/pages/edit_video_details_page.dart';
import 'package:new_artist_project/ui/pages/forgot_password_page.dart';
import 'package:new_artist_project/ui/pages/home/homePage.dart';
import 'package:new_artist_project/ui/pages/login_page.dart';
import 'package:new_artist_project/ui/pages/my_application_page.dart';
import 'package:new_artist_project/ui/pages/notification_page.dart';
import 'package:new_artist_project/ui/pages/sign_up_page.dart';
import 'package:new_artist_project/ui/pages/video_details.dart';
import 'package:new_artist_project/ui/pages/watching_video_page.dart';
import 'package:new_artist_project/ui/pages/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class Routes {
  //All routes names
  static const String COMMENT_REPLIES = "comment_replies";
  static const String EDIT_VIDEO_DETAILS_PAGE = "edit_video_details_page";
  static const String WATCHING_VIDEO_PAGE = "watching_video_page";
  static const String SIGN_UP_PAGE = "sign_up_page";
  static const String HOME_PAGE = "home_page";
  static const String LOGIN_PAGE = "login_page";
  static const String AUDITION_DETAIL_PAGE = "audition_page";
  static const String ARTIST_PROFILE_PAGE = "artist_profile_page";
  static const String ADD_EXPERIENCE_PAGE = "add_experience_page";
  static const String ADD_CREDITS_PAGE = "add_credits_page";
  static const String ADD_BIO_PAGE = "add_bio_page";
  static const String ARTISTS_PAGE = "artists_page";
  static const String BLOCKED_AGENCY_PAGE = "blocked_agency_page";
  static const String AGENCY_PROFILE_PAGE = "agency_profile_page";
  static const String WISHLIST = "wishlist";
  static const String AUDITION_TRACKING_PAGE = "audition_tracking_page";
  static const String VIDEO_DETAILS_PAGE = "video_details_page";
  static const String MY_APPLICATION_PAGE = "my_application_page";
  static const String NOTIFICATIONS_PAGE = "notifications_page";
  static const String CHAT_DETAILS_PAGE = "chat_details_page";
  static const String FORGOT_PASSWORD_PAGE = "forgot_password_page";
  //instance of sailor
  static final sailor = Sailor(
    options: SailorOptions(handleNameNotFoundUI: true, isLoggingEnabled: false),
  );

  static void initRoutes() {
    final List<SailorRoute> sailorRoutes = [
      SailorRoute(
          name: COMMENT_REPLIES,
          builder: (context, args, params) => MultiProvider(
                providers: [
                  Provider(
                    create: (context) => VideoBloc(),
                    dispose: (context, bloc) => bloc.dispose(),
                  ),
                ],
                child: CommentReplies(
                  commentModel: params.param(ParameterKey.COMMENT_MODEL),
                  artistVideoResponse:
                      params.param(ParameterKey.VIDEO_RESPONSE),
                  artistProfileResponse:
                      params.param(ParameterKey.OTHER_ARTIST_PROFILE),
                ),
              ),
          params: [
            SailorParam(
              name: ParameterKey.COMMENT_MODEL,
              defaultValue: null,
              isRequired: true,
            ),
            SailorParam(
              name: ParameterKey.OTHER_ARTIST_PROFILE,
              defaultValue: null,
              isRequired: true,
            ),
            SailorParam(
              name: ParameterKey.VIDEO_RESPONSE,
              defaultValue: null,
              isRequired: true,
            ),
          ]),
      SailorRoute(
          name: EDIT_VIDEO_DETAILS_PAGE,
          builder: (context, args, params) => Provider(
                create: (context) => VideoBloc(),
                dispose: (context, bloc) => bloc.dispose(),
                child: EditVideoDetailsPage(
                  artistVideoResponse:
                      params.param(ParameterKey.VIDEO_RESPONSE),
                ),
              ),
          params: [
            SailorParam(
              name: ParameterKey.VIDEO_RESPONSE,
              isRequired: true,
              defaultValue: null,
            ),
          ]),
      SailorRoute(
          name: WATCHING_VIDEO_PAGE,
          builder: (context, args, params) => Provider(
                create: (context) => VideoBloc(),
                dispose: (context, bloc) => bloc.dispose(),
                child: WatchingVideoPage(
                    artistVideoResponse:
                        params.param(ParameterKey.VIDEO_RESPONSE),
                    artistVideos:
                        params.param(ParameterKey.VIDEO_RESPONSE_LIST),
                    artistProfileResponse:
                        params.param(ParameterKey.OTHER_ARTIST_PROFILE),
                    isLoggedIn: params.param(ParameterKey.IS_LOGGED_IN)),
              ),
          params: [
            SailorParam(
              name: ParameterKey.OTHER_ARTIST_PROFILE,
              isRequired: true,
              defaultValue: null,
            ),
            SailorParam(
              name: ParameterKey.VIDEO_RESPONSE_LIST,
              isRequired: true,
              defaultValue: null,
            ),
            SailorParam(
              name: ParameterKey.VIDEO_RESPONSE,
              isRequired: true,
              defaultValue: null,
            ),
            SailorParam(
              name: ParameterKey.IS_LOGGED_IN,
              isRequired: true,
              defaultValue: null,
            )
          ]),
      SailorRoute(
        name: SIGN_UP_PAGE,
        builder: (context, args, params) => Provider(
          create: (context) => AuthenticationBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: SignUpPage(),
        ),
      ),
      SailorRoute(
        name: FORGOT_PASSWORD_PAGE,
        builder: (context, args, params) => Provider(
          create: (context) => AuthenticationBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: ForgotPasswordPage(),
        ),
      ),
      SailorRoute(
        name: AUDITION_DETAIL_PAGE,
        builder: (context, args, params) => Provider(
          create: (context) => AuditionBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: AuditionDetailPage(
            auditionResponse: params.param(
              ParameterKey.AUDITION,
            ),
          ),
        ),
        params: [
          SailorParam(
            isRequired: true,
            name: ParameterKey.AUDITION,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: LOGIN_PAGE,
        builder: (context, args, params) => Provider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: LoginPage(),
        ),
      ),
      SailorRoute(
          name: HOME_PAGE,
          builder: (context, args, params) => MultiProvider(
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
                child: HomePage(
                  isLoggedIn: params.param(ParameterKey.IS_LOGGED_IN),
                ),
              ),
          params: [
            SailorParam(
              name: ParameterKey.IS_LOGGED_IN,
              isRequired: false,
              defaultValue: true,
            ),
          ]),
      SailorRoute(
        name: ARTIST_PROFILE_PAGE,
        builder: (context, args, params) => Provider<ArtistProfileBloc>(
          create: (context) => ArtistProfileBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: ArtistProfilePage(
            isLoggedIn: params.param(ParameterKey.IS_LOGGED_IN),
            otherArtistProfile: params.param(ParameterKey.OTHER_ARTIST_PROFILE),
            category: params.param(ParameterKey.OTHER_ARTIST_PROFILE_CATEGORY),
          ),
        ),
        params: [
          SailorParam(
            isRequired: false,
            defaultValue: null,
            name: ParameterKey.OTHER_ARTIST_PROFILE,
          ),
          SailorParam(
            isRequired: false,
            defaultValue: null,
            name: ParameterKey.OTHER_ARTIST_PROFILE_CATEGORY,
          ),
          SailorParam(
            isRequired: true,
            defaultValue: false,
            name: ParameterKey.IS_LOGGED_IN,
          )
        ],
      ),
      SailorRoute(
          name: ADD_EXPERIENCE_PAGE,
          builder: (context, args, params) => Provider<ArtistBioBloc>(
                create: (context) => ArtistBioBloc(),
                dispose: (context, bloc) => bloc.dispose(),
                child: AddExperiencePage(
                  artistExperienceModel:
                      params.param(ParameterKey.ARTIST_EXPERIENCE_MODEL),
                ),
              ),
          params: [
            SailorParam(
              isRequired: false,
              defaultValue: null,
              name: ParameterKey.ARTIST_EXPERIENCE_MODEL,
            )
          ]),
      SailorRoute(
        name: ADD_CREDITS_PAGE,
        builder: (context, args, params) => Provider<ArtistBioBloc>(
          create: (context) => ArtistBioBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: AddCreditPage(
            artistCreditModel: params.param(ParameterKey.ARTIST_CREDIT_MODEL),
          ),
        ),
        params: [
          SailorParam(
            isRequired: false,
            defaultValue: null,
            name: ParameterKey.ARTIST_CREDIT_MODEL,
          )
        ],
      ),
      SailorRoute(
        name: ADD_BIO_PAGE,
        builder: (context, args, params) => MultiProvider(
          providers: [
            Provider<ArtistBioBloc>(
              create: (context) => ArtistBioBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<GlobalBloc>(
              create: (context) => GlobalBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: AddArtistBioPage(),
        ),
      ),
      SailorRoute(
        name: ARTISTS_PAGE,
        builder: (context, args, params) => Provider(
          create: (context) => AllArtistBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: ArtistsPage(
            isLoggedIn: params.param(ParameterKey.IS_LOGGED_IN),
            categorisedArtistList:
                params.param(ParameterKey.CATEGORY_ARTIST_MAP),
          ),
        ),
        params: [
          SailorParam(
            name: ParameterKey.IS_LOGGED_IN,
            isRequired: true,
            defaultValue: false,
          ),
          SailorParam(
              name: ParameterKey.CATEGORY_ARTIST_MAP,
              isRequired: true,
              defaultValue: {}),
        ],
      ),
      SailorRoute(
        name: BLOCKED_AGENCY_PAGE,
        builder: (context, args, params) => MultiProvider(
          providers: [
            Provider(
              create: (context) => AgencyProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],child: BlockedAgencyPage(),
        ),
      ),
      SailorRoute(
        name: AGENCY_PROFILE_PAGE,
        builder: (context, args, params) => MultiProvider(
          providers: [
            Provider(
              create: (context) => AgencyProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider(
              create: (context) => AuditionBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: AgencyProfilePage(
            agencyProfileResponse:
                params.param(ParameterKey.AGENCY_PROFILE_RESPONSE),
          ),
        ),
        params: [
          SailorParam(
              name: ParameterKey.AGENCY_PROFILE_RESPONSE,
              isRequired: true,
              defaultValue: null)
        ],
      ),
      SailorRoute(
        name: WISHLIST,
        builder: (context, args, params) => MultiProvider(
          providers: [
            Provider(
              create: (context) => AuditionBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: WishListPage(),
        ),
      ),
      SailorRoute(
        name: AUDITION_TRACKING_PAGE,
        builder: (context, args, params) => AuditionTrackingPage(),
      ),
      SailorRoute(
          name: VIDEO_DETAILS_PAGE,
          builder: (context, args, params) => MultiProvider(
                providers: [
                  Provider(
                    create: (context) => GlobalBloc(),
                    dispose: (context, bloc) => bloc.dispose(),
                  ),
                ],
                child: BuildVideoDetails(
                  file: params.param(ParameterKey.VIDEO_KEY),
                ),
              ),
          params: [
            SailorParam(
                name: ParameterKey.VIDEO_KEY,
                isRequired: true,
                defaultValue: null)
          ]),
      SailorRoute(
        name: MY_APPLICATION_PAGE,
        builder: (context, args, params) => MultiProvider(
          providers: [
            Provider(
              create: (context) => AuditionBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: MyApplicationPage(),
        ),
      ),
      SailorRoute(
        name: NOTIFICATIONS_PAGE,
        builder: (context, args, params) => NotificationPage(),
      ),
      SailorRoute(
        name: CHAT_DETAILS_PAGE,
        builder: (context, args, params) => ChatDetailsPage(data: params.param('data')),
      params: [
        SailorParam(name: 'data',defaultValue: null,isRequired: false),
      ]),
    ];
    sailor.addRoutes(sailorRoutes);
  }

  static Future<T> navigate<T>(
    String routeName, {
    Object args,
    Map<String, dynamic> params,
  }) {
    return sailor.navigate(routeName, args: args, params: params);
  }
}
