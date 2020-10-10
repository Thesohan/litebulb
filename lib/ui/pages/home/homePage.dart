import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc_event.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc_event.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc_event.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/agency_model.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/category_Artists_model.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/models/sponser_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/agency/buildAgencyList.dart';
import 'package:new_artist_project/ui/artists/build_artist_list.dart';
import 'package:new_artist_project/ui/auditions/buildAuditionList.dart';
import 'package:new_artist_project/ui/pages/home/buildAuditions.dart';
import 'package:new_artist_project/ui/pages/home/buildchatScreen.dart';
import 'package:new_artist_project/ui/pages/video_details.dart';
import 'package:new_artist_project/ui/sponsers/sponserList.dart';
import 'package:new_artist_project/ui/widgets/dialogs/primary_confirmation_dialog.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/ui/widgets/title_with_show_all_button.dart';
import 'package:new_artist_project/util/id_name_converter.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

const int HOMEPAGE_INDEX = 0;
const int AGENCY_LIST_INDEX = 1;
const int UPLOAD_VIDEO = 2;
const int AUDITIONS = 3;
const int MESSAGES = 4;

class HomePage extends StatefulWidget {
  final bool isLoggedIn;
  const HomePage({Key key, this.isLoggedIn = true}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllArtistBloc _allArtistBloc;
  AuditionBloc _auditionBloc;
  AgencyProfileBloc _agencyProfileBloc;
  GlobalBloc _globalBloc;
  ArtistProfileBloc _artistProfileBloc;
  AuthenticationBloc _authenticationBloc;
  VideoBloc _videoBloc;
  var _currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  bool _isExpanded = false;

  final _sponserList = List<Sponser>.generate(20, (index) {
    Sponser sponser = Sponser("shoan");
    return sponser;
  });
  final _agencyList = List<AgencyModel>.generate(20, (index) {
    return AgencyModel();
  });

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _allArtistBloc = Provider.of<AllArtistBloc>(context);
    _auditionBloc = Provider.of<AuditionBloc>(context);
    _agencyProfileBloc = Provider.of<AgencyProfileBloc>(context);
    _artistProfileBloc = Provider.of<ArtistProfileBloc>(context);
    _globalBloc = Provider.of<GlobalBloc>(context);
    _authenticationBloc = Provider.of<AuthenticationBloc>(context);
    _videoBloc = Provider.of<VideoBloc>(context);
    _globalBloc.dispatch(GetCategoryEvent());
    _allArtistBloc.dispatch(FetchAllArtistEvent());
    _artistProfileBloc.dispatch(
      FetchArtistBioEvent(),
    );
    _artistProfileBloc.getLoggedInArtistProfile();
    _artistProfileBloc.dispatch(FetchArtistExpOrCredEvent(value: 'experience'));
    _artistProfileBloc.dispatch(FetchArtistExpOrCredEvent(value: 'credits'));
    _artistProfileBloc.dispatch(FetchArtistVideoEvent());

    _auditionBloc.dispatch(
      FetchFeaturedAuditionBlocEvent(
        auditionRequest: AuditionRequest(is_featured: '1', agency_id: "All"),
      ),
    );
    _videoBloc.dispatch(UpdateCategoryDropDownValueEvent());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldStateKey,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      endDrawer: _buildDrawer(),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: _buildBody(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spaces.h64,
              StreamBuilder<Resource<ArtistProfileResponse>>(
                  stream: _artistProfileBloc.artistBioResponseObservable,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.data != null &&
                        snapshot.data.isSuccess) {
                      ArtistProfileResponse artistProfileResponse =
                          snapshot.data.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: artistProfileResponse.avatar_loc != null
                                ? Image.network(
                                    "https://${artistProfileResponse.avatar_loc}",
                                    width: SizeConfig.safeBlockVertical * 12,
                                    height: SizeConfig.safeBlockVertical * 12,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    ImageAssets.DANCE,
                                    width: SizeConfig.safeBlockVertical * 12,
                                    height: SizeConfig.safeBlockVertical * 12,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: PrimaryText(
                                  text: "${artistProfileResponse.name}",
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.HEADING,
                                ),
                              ),
                              Spaces.h8,
                              Center(
                                child: PrimaryText(
                                  text: "${artistProfileResponse.email}",
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
              Spaces.h32,
              RoundedButton(
                text: "View Profile",
                leftPadding: 64.0,
                rightPadding: 64.0,
                topPadding: 16.0,
                bottomPadding: 16.0,
                textColor: AppColors.black,
                onPressed: () {
                  if (widget.isLoggedIn) {
                    Routes.navigate(Routes.ARTIST_PROFILE_PAGE,
                        params: {ParameterKey.IS_LOGGED_IN: true});
                  } else {
                    _showAuthRequiredToast();
                  }
                },
              ),
              PrimaryDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      Routes.navigate(Routes.BLOCKED_AGENCY_PAGE);
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "Blocked Agency",
                    fontSize: AppConstants.SUB_HEADING,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      Routes.navigate(Routes.WISHLIST);
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "Wishlist",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      Routes.navigate(Routes.MY_APPLICATION_PAGE);
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "My Application",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      Routes.navigate(Routes.NOTIFICATIONS_PAGE);
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "Notification",
                  ),
                ),
              ),
              PrimaryDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      Routes.navigate(Routes.AUDITION_TRACKING_PAGE);
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "Invite Friend",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListTile(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      _logoutArtist();
                    } else {
                      _showAuthRequiredToast();
                    }
                  },
                  title: PrimaryText(
                    text: "Logout",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.black),
      leading: Container(
        margin: EdgeInsets.all(8.0),
        height: 32.0,
        width: 64.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(ImageAssets.APPICON),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentPageIndex) {
      case HOMEPAGE_INDEX:
        return _buildHomePage();
      case AGENCY_LIST_INDEX:
        return _buildAgencyList();
      case UPLOAD_VIDEO:
        return _buildUploadVideo();
      case AUDITIONS:
        return StreamBuilder<CategoryListModel>(
            stream: _globalBloc.categoryObservable,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.categoryList != null) {
                return BuildAuditions(categories: snapshot.data.categoryList);
              } else {
                return SpinKitFadingCircle(
                  color: AppColors.red,
                );
              }
            });
      case MESSAGES:
        return _buildMessages();
    }
    return _buildHomePage();
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: AppColors.white,
            ),
            onPressed: () {
              _updateWidget(HOMEPAGE_INDEX);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.color_lens,
              color: Colors.white,
            ),
            onPressed: () {
              _updateWidget(AGENCY_LIST_INDEX);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () {
              _updateWidget(UPLOAD_VIDEO);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.radio,
              color: Colors.white,
            ),
            onPressed: () {
              _updateWidget(AUDITIONS);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              _updateWidget(MESSAGES);
            },
          ),
        ],
      ),
    );
  }

  void _updateWidget(int index) {
    setState(
      () {
        _currentPageIndex = index;
      },
    );
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(left: 16.0),
        children: <Widget>[
          StreamBuilder<Resource<AuditionListResponse>>(
              stream: _auditionBloc.auditionListBehaviourObservable,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot.data.isSuccess) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, top: 24.0, bottom: 8.0, right: 16.0),
                        child: TitleWithShowAllButton(
                          title: "Auditions",
                          buttonText: "Show All +",
                          onPressed: () {
                            setState(() {
                              _currentPageIndex = AUDITIONS;
                            });
                          },
                        ),
                      ),
                      BuildAuditionList(
                        isLoggedIn: widget.isLoggedIn,
                        scrollDirection: Axis.horizontal,
                        auditionList: snapshot.data.data.data,
                      ),
                      PrimaryDivider(
                        leftPadding: 0.0,
                        rightPadding: 16.0,
                        topPadding: 24.0,
                        bottomPadding: 16.0,
                      ),
                    ],
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: AppColors.red,
                    size: 32.0,
                  );
                }
              }),
          StreamBuilder<Resource<CategoryArtistsModel>>(
              stream: _allArtistBloc.allArtistInfoObservable,
              builder: (context, allArtistSnapshot) {
                if (allArtistSnapshot != null &&
                    allArtistSnapshot.data != null &&
                    allArtistSnapshot.data.data != null &&
                    allArtistSnapshot.data.isSuccess &&
                    allArtistSnapshot.data.data.allArtistInfoResponse != null) {
                  AllArtistInfoResponse allArtistResponse =
                      allArtistSnapshot.data.data.allArtistInfoResponse;
                  Map<String, List<ArtistProfileResponse>>
                      categorisedArtistList = _getCategorizedArtistList(
                    allArtistResponse.data,
                    allArtistSnapshot.data.data.categories,
                  );
                  List<ArtistProfileResponse> tempList = [];
                  if (categorisedArtistList.keys.toList().length > 0) {
                    tempList = categorisedArtistList[
                        categorisedArtistList.keys.toList()[0]];
                    if (tempList.length > 3) {
                      tempList = tempList.sublist(0, 3);
                    }
                  }

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          top: 8.0,
                          bottom: 8.0,
                          right: 16.0,
                        ),
                        child: TitleWithShowAllButton(
                          title: "Artists",
                          buttonText: "Show All +",
                          onPressed: () {
                            Routes.navigate(Routes.ARTISTS_PAGE, params: {
                              ParameterKey.CATEGORY_ARTIST_MAP:
                                  categorisedArtistList,
                              ParameterKey.IS_LOGGED_IN: widget.isLoggedIn,
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: BuildArtistList(
                          isLoggedIn: widget.isLoggedIn,
                          artistList: tempList,
                          category: tempList.length > 0
                              ? categorisedArtistList.keys.toList()[0]
                              : "",
                        ),
                      ),
                      PrimaryDivider(
                        leftPadding: 0.0,
                        rightPadding: 16.0,
                        topPadding: 24.0,
                        bottomPadding: 16.0,
                      ),
                    ],
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: AppColors.red,
                    size: 32.0,
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.only(
              left: 4.0,
              top: 8.0,
              bottom: 8.0,
              right: 16.0,
            ),
            child: TitleWithShowAllButton(
              title: "Sponsers",
            ),
          ),
          BuildSponserList(
            scrollDirection: Axis.horizontal,
            sponserList: _sponserList,
          ),
          Spaces.h64,
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return BuildChatScreen();
  }

  Widget _buildAgencyList() {
    _agencyProfileBloc.dispatch(
      FetchAllAgencyEvent(
        agencyProfileRequest: AgencyProfileRequest(username: 'All'),
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryText(
              text: "Agencies",
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.HEADING,
            ),
          ),
          StreamBuilder<Resource<AllAgencyProfileResponse>>(
              stream: _agencyProfileBloc.allAgencyProfileResponseObservable,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot.data.isSuccess) {
                  List<AgencyProfileResponse> agencies =
                      snapshot.data.data.data ?? [];
                  return BuildAgencyList(
                    agencyList: agencies,
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: AppColors.red,
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildUploadVideo() {
    return StreamBuilder<File>(
        stream: _videoBloc.videoFileObservable,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            return BuildVideoDetails(
                file: snapshot.data,
                onFinish: (String msg) {
                  _updateWidget(HOMEPAGE_INDEX);
                  _scaffoldStateKey.currentState.showSnackBar(
                    SnackBar(
                      content: PrimaryText(
                        text: "$msg",
                        color: AppColors.white,
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spaces.h32,
                  Container(
                    width: SizeConfig.safeBlockVertical * 30,
                    height: SizeConfig.safeBlockVertical * 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: SizeConfig.safeBlockVertical * 20,
                    ),
                  ),
                  Spaces.h64,
                  PrimaryText(
                    text: "Upload Your Talent Here",
                    fontSize: AppConstants.SUB_HEADING,
                    color: AppColors.pink,
                  ),
                  Spaces.h64,
                  PrimaryButton(
                    text: "Choose A Video",
                    onPressed: () {
                      _videoBloc.dispatch(ChooseVideoEvent());
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Map<String, List<ArtistProfileResponse>> _getCategorizedArtistList(
      List<ArtistProfileResponse> artistProfileResponses,
      List<CategoryModel> categories) {
    Map<String, List<ArtistProfileResponse>> artistMap = {};
    IdNameConverter categoryConverter =
        IdNameConverter(categoryList: categories);

    artistProfileResponses?.forEach((artist) {
      String cat =
          categoryConverter.getCategoryNameFromId(categoryId: artist.category);
      if (artistMap[cat] != null) {
        artistMap[cat].add(artist);
      } else {
        artistMap[cat] = [];
        artistMap[cat].add(artist);
      }
    });
    return artistMap;
  }

  void _showAuthRequiredToast() {
    Navigator.pop(context);
    this._scaffoldStateKey.currentState.showSnackBar(
          SnackBar(
            content: PrimaryText(
              text: "Authentication Required",
              color: AppColors.white,
            ),
          ),
        );
  }

  void _logoutArtist() {
    PrimaryConfirmationDialog.show(context,
        okButtonNavigationHandled: true,
        showCancelButton: true,
        message: 'Do you really want to logout?',
        onCancelTapped: () {}, onOkTapped: () {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: AppColors.red,
          );
        },
      );
      _authenticationBloc.dispatch(
        LogoutEvent(
          completer: Completer()
            ..future.then((msg) {
              /// popping loading screen
              Navigator.of(context).pop();

              /// popping drawer
              Navigator.of(context).pop();
              if (msg == "User logged out.") {
                Routes.navigate(Routes.LOGIN_PAGE);
              } else {
                _scaffoldStateKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("$msg"),
                  ),
                );
              }
            }),
        ),
      );
    });
  }

  Future<bool> _onBackPressed() async {
    if (_currentPageIndex == HOMEPAGE_INDEX) {
      return true;
    }
    _updateWidget(HOMEPAGE_INDEX);
    return false;
  }
}
