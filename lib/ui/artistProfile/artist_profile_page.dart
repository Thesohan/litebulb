import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/no_of_subscriber_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/artistProfile/artist_bio_page.dart';
import 'package:new_artist_project/ui/artistProfile/artist_credits.dart';
import 'package:new_artist_project/ui/artistProfile/artist_experience.dart';
import 'package:new_artist_project/ui/artistProfile/artistVideos.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class ArtistProfilePage extends StatefulWidget {
  const ArtistProfilePage(
      {Key key,
      this.otherArtistProfile,
      this.category,
      this.isLoggedIn = false})
      : super(key: key);
  final ArtistProfileResponse otherArtistProfile;
  final String category;
  final bool isLoggedIn;
  @override
  _ArtistProfilePageState createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage>
    with SingleTickerProviderStateMixin {
  Future _getImage(bool isSourceCamera) async {
    File image;
    if (isSourceCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      /// Usually we convert files into base64 string , but here we are not doing this because our needs are different.
//      List<int> imageBytes = await image.readAsBytes();
//      String base64Image = base64Encode(imageBytes);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: AppColors.red,
          );
        },
      );

      _bloc.dispatch(
        UpdateProfileEvent(
          thumbnail: image,
          completer: Completer()
            ..future.then((data) {
              /// popping dialog
              Navigator.of(context).pop();
              if (data != null) {
                _bloc.dispatch(FetchArtistBioEvent());
              } else {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Error while updating profile pic. "),
                  ),
                );
              }
            }),
        ),
      );
    }
  }

  TabController _tabController;
  int _currentTabIndex = 0;
  ArtistProfileBloc _bloc;
  bool _isSubscribe;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    _bloc = Provider.of<ArtistProfileBloc>(context);
    if (widget.isLoggedIn) {
      _bloc.dispatch(FetchNoOfSubscriberEvent());
    } else if (widget.otherArtistProfile != null) {
      _bloc.dispatch(
        FetchNoOfSubscriberEvent(followingId: widget.otherArtistProfile.id),
      );
    }
    super.didChangeDependencies();
  }

  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    _isSubscribe = widget.otherArtistProfile != null
        ? widget.otherArtistProfile.is_subscribed == '1'
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _currentTabIndex == 1 &&
              widget.otherArtistProfile == null &&
              widget.isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                Routes.navigate(Routes.ADD_BIO_PAGE);
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 26,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )
          : Container(),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildSliverAppBar(context),
              _buildSliverPersistentHeader(context),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Videos(
                artistProfileBloc: _bloc,
                isLoggedIn: widget.isLoggedIn,
                artistProfileResponse: widget.otherArtistProfile,
              ),
              ArtistBio(
                otherArtistProfile: widget.otherArtistProfile,
                category: widget.category,
                isLoggedIn: widget.isLoggedIn,
                bloc: _bloc,
              ),
              Experience(
                isLoggedIn: widget.isLoggedIn,
                artistProfileBloc: _bloc,
                otherArtistProfile: widget.otherArtistProfile,
              ),
              Credits(
                isLoggedIn: widget.isLoggedIn,
                otherArtistProfile: widget.otherArtistProfile,
                artistProfileBloc: _bloc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _buildSliverPersistentHeader(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          isScrollable: false,
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.safeBlockHorizontal * AppConstants.NORMAL,
            fontFamily: 'Montserrat.Medium',
          ),
          tabs: [
            Tab(text: "Videos"),
            Tab(text: "Bio"),
            Tab(text: "Experience"),
            Tab(text: 'Credits')
          ],
        ),
      ),
      pinned: false,
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: widget.isLoggedIn && widget.otherArtistProfile == null
          ? StreamBuilder<Resource<ArtistProfileResponse>>(
              stream: _bloc.artistBioResponseObservable,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot?.data?.data != null) {
                  ArtistProfileResponse artistProfileResponse =
                      snapshot.data.data;
                  return _buildFlexibleSpaceBar(artistProfileResponse);
                } else
                  return SpinKitFadingCircle(
                    color: AppColors.white,
                  );
              })
          : _buildFlexibleSpaceBar(widget.otherArtistProfile),
    );
  }

  void _showCupertinoPopup() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: PrimaryText(
            text: "Profile Photo",
          ),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: PrimaryText(
              text: 'Cancel',
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CupertinoActionSheetAction(
                        child: Icon(
                          Icons.camera_enhance,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _getImage(true);

                          Navigator.pop(context);
                        },
                      ),
                      PrimaryText(
                        text: "Camera",
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CupertinoActionSheetAction(
                        child: Icon(
                          Icons.insert_drive_file,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _getImage(false);

                          Navigator.pop(context);
                        },
                      ),
                      PrimaryText(
                        text: "Gallery",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlexibleSpaceBar(ArtistProfileResponse artistProfileResponse) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: PrimaryText(
        text: "${artistProfileResponse.name}",
        color: AppColors.white,
      ),
      background: Row(
        children: <Widget>[
          Expanded(
            flex:
                widget.isLoggedIn && widget.otherArtistProfile == null ? 1 : 2,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: SizeConfig.safeBlockVertical * 12,
                    width: SizeConfig.safeBlockVertical * 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      image: DecorationImage(
                        image: artistProfileResponse.avatar_loc == null
                            ? AssetImage(ImageAssets.DANCE)
                            : NetworkImage(
                                "https://${artistProfileResponse.avatar_loc}",
                              ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -16.0,
                    right: -16.0,
                    child: widget.otherArtistProfile == null
                        ? IconButton(
                            icon: Icon(
                              Icons.camera_enhance,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              _showCupertinoPopup();
                            },
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<Resource<NoOfSubscriberResponse>>(
                  stream: _bloc.noOfSubscribersObservable,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.data != null &&
                        snapshot.data.isSuccess) {
                      int numberOfSubscribers = snapshot.data?.data?.data;
                      return Column(
                        children: <Widget>[
                          PrimaryText(
                            text:
                                "$numberOfSubscribers${numberOfSubscribers > 1 ? " Subscribers" : " Subscriber"}",
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          Spaces.h4,
                          widget.otherArtistProfile != null && widget.isLoggedIn
                              ? PrimaryButton(
                                  text: _isSubscribe
                                      ? "Unsubscribe"
                                      : "Subscribe",
                                  onPressed: () {
                                    _bloc.dispatch(
                                      SubscriptionEvent(
                                        followingId:
                                            widget.otherArtistProfile.id,
                                        completer: Completer()
                                          ..future.then((msg) {
                                            if (msg == 'Subscribed') {
                                              setState(() {
                                                _isSubscribe = true;
                                              });
                                            } else if (msg ==
                                                'You unsubscribed') {
                                              setState(() {
                                                _isSubscribe = false;
                                              });
                                            } else {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: PrimaryText(
                                                    text: "$msg",
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                      ),
                                    );
                                  },
                                  textColor: AppColors.red,
                                  color: AppColors.white,
                                )
                              : Container(),
                        ],
                      );
                    }
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: AppColors.white,
                        size: 24.0,
                      ),
                    );
                  }),
            ],
          ),
          Spaces.w32,
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: AppColors.primary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
