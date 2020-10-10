import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neeko/neeko.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/comment_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/comments/buildCommentList.dart';
import 'package:new_artist_project/ui/widgets/primary_expandable.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class WatchingVideoPage extends StatefulWidget {
  final ArtistVideoResponse artistVideoResponse;
  final List<ArtistVideoResponse> artistVideos;
  final ArtistProfileResponse artistProfileResponse;
  final bool isLoggedIn;
  const WatchingVideoPage({
    Key key,
    @required this.artistProfileResponse,
    @required this.artistVideoResponse,
    @required this.artistVideos,
    this.isLoggedIn = false,
  })  : assert(artistVideoResponse != null && artistVideos != null),
        super(key: key);

  @override
  _WatchingVideoPageState createState() {
    return _WatchingVideoPageState();
  }
}

class _WatchingVideoPageState extends State<WatchingVideoPage> {
  bool _isExpanded = false;
  VideoControllerWrapper _videoControllerWrapper;
  VideoBloc _videoBloc;
  bool _isLiked;
  int _noOfLikes;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    _videoBloc = Provider.of<VideoBloc>(context);
    _videoBloc.dispatch(
      FetchCommentsEvent(
        commentRequest: CommentRequest(
          object_id: widget.artistVideoResponse.video_id,
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    _videoControllerWrapper = VideoControllerWrapper(
      DataSource.network('${widget.artistVideoResponse.location}',
          displayName: "${widget.artistProfileResponse.name}"),
    );
    _isLiked = widget.artistVideoResponse.is_liked == '1';
    _noOfLikes = int.parse(widget.artistVideoResponse.no_oflikes.trim());
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    _videoControllerWrapper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (widget.isLoggedIn) {
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Routes.navigate(Routes.EDIT_VIDEO_DETAILS_PAGE, params: {
                  ParameterKey.VIDEO_RESPONSE: widget.artistVideoResponse
                });
              } else {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: PrimaryText(
                      text: "Authentication Required!!!",
                      color: AppColors.white,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Edit", child: PrimaryText(text: "Edit"))
              ];
            },
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        NeekoPlayerWidget(
          videoControllerWrapper: _videoControllerWrapper,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        Expanded(
          child: ListView(
            primary: true,
            shrinkWrap: true,
            children: <Widget>[
              infoCard(context),
              nextPlaylist(context),
              StreamBuilder<Resource<CommentResponse>>(
                  stream: _videoBloc.commentsObservable,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.data != null &&
                        snapshot.data.isSuccess) {
                      CommentResponse commentResponse = snapshot.data.data;
                      return BuildCommentList(
                        isLoggedIn:widget.isLoggedIn,
                        artistProfileResponse: widget.artistProfileResponse,
                        artistVideoResponse: widget.artistVideoResponse,
                        commentModel: commentResponse.data,
                      );
                    }
                    return SpinKitFadingCircle(
                      color: AppColors.red,
                      size: 24.0,
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }

  Widget infoCard(BuildContext context) {
    return Card(
      elevation: AppConstants.CARD_ELEVATION,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
        child: Column(
          children: <Widget>[
            PrimaryExpandableCard(
              header: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: widget.artistProfileResponse.avatar_loc != null
                        ? Image.network(
                            "https://${widget.artistProfileResponse.avatar_loc}",
                            width: SizeConfig.safeBlockVertical * 8,
                            height: SizeConfig.safeBlockVertical * 8,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            ImageAssets.PERSONLOGO,
                            width: SizeConfig.safeBlockVertical * 8,
                            height: SizeConfig.safeBlockVertical * 8,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Spaces.w8,
                  PrimaryText(
                    text: "${widget.artistProfileResponse.name}",
                    fontSize: AppConstants.SUB_HEADING,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 28.0,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PrimaryText(
                      text: "${widget.artistVideoResponse.description}"),
                  Spaces.h8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PrimaryText(
                        text: 'Category',
                        color: AppColors.red,
                      ),
                      Spaces.w32,
                      PrimaryText(
                        text: "${widget.artistVideoResponse.Category}",
                      ),
                    ],
                  ),
                  Spaces.h8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _videoBloc.dispatch(
                            UpdateVideoLikeStatusEvent(
                                videoId: widget.artistVideoResponse.video_id,
                                completer: _likeStatusCompleter()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _isLiked
                                ? Icon(
                                    Icons.thumb_up,
                                    color: AppColors.pink,
                                  )
                                : Icon(
                                    Icons.thumb_up,
                                    color: AppColors.gray,
                                  ),
                            PrimaryText(text: "$_noOfLikes"),
                          ],
                        ),
                      ),
                      Spaces.w24,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          Transform(
//                              alignment: Alignment.center,
//                              transform: Matrix4.rotationY(math.pi),
//                              child: Icon(
//                                Icons.reply,
//                                color: Colors.pinkAccent,
//                              ),
//                          ),
                          PrimaryText(
                            text: "Uploaded On",
                            color: AppColors.red,
                          ),
                          PrimaryText(
                            text:
                                "${widget.artistVideoResponse.uploaded_at?.split(' ')[0]}",
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              onExpandListener: (isExpanded) {
                setState(() {
                  _isExpanded = isExpanded;
                });
              },
              isExpanded: _isExpanded,
            ),
          ],
        ),
      ),
    );
  }

  Widget nextPlaylist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Next Play',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _buildVideo(widget.artistVideos[index]);
            },
            itemCount: widget.artistVideos.length,
          ),
        ],
      ),
    );
  }

//  Widget listCard() {
//    return Padding(
//      padding: const EdgeInsets.all(16.0),
//      child: Row(
//        children: <Widget>[
//          Card(
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(8),
//              child: widget.artistVideoResponse.thumbnail_url != null
//                  ? Image.network(
//                      "${widget.artistVideoResponse.thumbnail_url}",
//                      width: SizeConfig.safeBlockVertical * 12,
//                      height: SizeConfig.safeBlockVertical * 12,
//                      fit: BoxFit.cover,
//                    )
//                  : Image.asset(
//                      ImageAssets.DANCE,
//                      width: SizeConfig.safeBlockVertical * 12,
//                      height: SizeConfig.safeBlockVertical * 12,
//                      fit: BoxFit.cover,
//                    ),
//            ),
//          ),
//          Spaces.w8,
//          Expanded(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                PrimaryText(
//                  text: "playlist song number one",
//                ),
//                Spaces.h16,
//                PrimaryText(
//                  text: "Description of the song and other ",
//                ),
//                PrimaryText(
//                  text: "134 Views",
//                )
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }

  Widget _buildVideo(ArtistVideoResponse artistVideoResponse) {
    return InkWell(
      onTap: () {
        widget.artistVideos.remove(artistVideoResponse);
        widget.artistVideos.add(widget.artistVideoResponse);
        Routes.navigate(Routes.WATCHING_VIDEO_PAGE, params: {
          ParameterKey.VIDEO_RESPONSE: artistVideoResponse,
          ParameterKey.VIDEO_RESPONSE_LIST: widget.artistVideos
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Container(
          height: SizeConfig.safeBlockVertical * 14,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: artistVideoResponse.thumbnail_url != null
                    ? Image.network(
                        "${artistVideoResponse.thumbnail_url}",
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: PrimaryText(
                          maxLines: 1,
                          text: "${artistVideoResponse.title}",
                          fontSize: AppConstants.SUB_HEADING,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spaces.h8,
                      Flexible(
                        child: PrimaryText(
                          maxLines: 3,
                          color: AppColors.grayText,
                          fontSize: AppConstants.SMALL,
                          text: "${artistVideoResponse.description}",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Completer _likeStatusCompleter() {
    return Completer()
      ..future.then(
        (msg) {
          if (msg == 'Liked') {
            setState(() {
              _isLiked = true;
              _noOfLikes = _noOfLikes + 1;
            });
          } else if (msg == 'removed from liked') {
            setState(() {
              _isLiked = false;

              _noOfLikes = _noOfLikes - 1;
            });
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: PrimaryText(
                  text: "Something Went Wrong!!!",
                  color: AppColors.white,
                ),
              ),
            );
          }
        },
      );
  }
}
