import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/add_comment_model.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/api/comment_model.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class BuildCommentList extends StatefulWidget {
  const BuildCommentList({
    Key key,
    @required this.commentModel,
    this.scrollDirection = Axis.vertical,
    @required this.artistProfileResponse,
    @required this.artistVideoResponse,
    this.isLoggedIn = false,
  }) : super(key: key);

  final bool isLoggedIn;
  final ArtistVideoResponse artistVideoResponse;
  final ArtistProfileResponse artistProfileResponse;
  final List<CommentModel> commentModel;
  final Axis scrollDirection;

  @override
  _BuildCommentListState createState() {
    return _BuildCommentListState();
  }
}

class _BuildCommentListState extends State<BuildCommentList> {
  TextEditingController _commentEditingController;
  List<CommentModel> commentModelList;
  @override
  void initState() {
    _commentEditingController = TextEditingController();
    commentModelList = widget.commentModel;
    super.initState();
  }

  @override
  void dispose() {
    _commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VideoBloc videoBloc = Provider.of<VideoBloc>(context);
    TextEditingController _commentEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: PrimaryText(
            text: "Comments",
            fontSize: AppConstants.HEADING,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.safeBlockVertical * 8),
                    child: Image.asset(
                      ImageAssets.DANCE,
                      width: SizeConfig.safeBlockVertical * 8,
                      height: SizeConfig.safeBlockVertical * 8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spaces.w8,
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.isLoggedIn) {
                          _showDialog(videoBloc);
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: PrimaryText(
                                text: "Authentication Required!!!",
                                color: AppColors.white,
                              ),
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: PrimaryText(
                          text: "+ Add Comment",
                        ),
                      ),
                    ),
                  ),
                  Spaces.w16,
                ],
              ),
            ),
          ),
        ),
        ListView.separated(
          primary: false,
          scrollDirection: widget.scrollDirection,
          shrinkWrap: true,
          itemCount: commentModelList.length,
          itemBuilder: (context, index) {
            return _BuildCommentItem(
              isLoggedIn: widget.isLoggedIn,
              comment: commentModelList[index],
              artistVideoResponse: widget.artistVideoResponse,
              artistProfileResponse: widget.artistProfileResponse,
            );
          },
          separatorBuilder: (context, index) {
            return Spaces.h8;
          },
        ),
      ],
    );
  }

  Completer _addCommentCompleter(VideoBloc videoBloc) {
    return Completer()
      ..future.then((data) {
        Navigator.of(context).pop();
        if (data != null) {
          Navigator.of(context).pop();
          videoBloc.dispatch(
            FetchCommentsEvent(
              commentRequest: CommentRequest(
                  object_id: widget.artistVideoResponse.video_id),
            ),
          );
        }
      });
  }

  void _showDialog(VideoBloc videoBloc) async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Comment',
                ),
                controller: _commentEditingController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new PrimaryButton(
              text: 'CANCEL',
              onPressed: () {
                Navigator.pop(context);
              }),
          PrimaryButton(
            text: "Comment",
            onPressed: () {
              videoBloc.dispatch(
                AddCommentEvent(
                  addCommentModel: AddCommentModel(
                    object_id: widget.artistVideoResponse.video_id,
                    comment_id: "",
                    sender_username: widget.artistProfileResponse.username,
                    comment_text: _commentEditingController.text ?? "",
                    visible: '1',
                    reply: "",
                    rating_cache: "",
                    access_key: "",
                  ),
                  completer: _addCommentCompleter(videoBloc),
                ),
              );

              showDialog(
                context: context,
                barrierDismissible: false,
                child: SpinKitFadingCircle(
                  color: AppColors.red,
                  size: 24.0,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _BuildCommentItem extends StatelessWidget {
  const _BuildCommentItem(
      {Key key,
      this.comment,
      this.artistVideoResponse,
      this.artistProfileResponse,
      this.isLoggedIn = false})
      : super(key: key);

  final bool isLoggedIn;
  final CommentModel comment;
  final ArtistVideoResponse artistVideoResponse;
  final ArtistProfileResponse artistProfileResponse;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 24,
        child: Card(
          elevation: AppConstants.CARD_ELEVATION,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.safeBlockVertical * 8),
                  child: comment.profile_url != null
                      ? Image.network(
                          'https://${comment.profile_url}',
                          width: SizeConfig.safeBlockVertical * 8,
                          height: SizeConfig.safeBlockVertical * 8,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          ImageAssets.PERSONLOGO,
                          width: SizeConfig.safeBlockVertical * 8,
                          height: SizeConfig.safeBlockVertical * 8,
                          fit: BoxFit.cover,
                        ),
                ),
                Spaces.w8,
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spaces.h8,
                      PrimaryText(
                        text: "${comment.Fullname}",
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                      ),
                      PrimaryText(
                        text: "${comment.Message}",
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                color: Colors.pinkAccent,
                              ),
                              PrimaryText(text: "1"),
                            ],
                          ),
                          Spaces.w16,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.thumb_down,
                                color: Colors.pinkAccent,
                              ),
                              PrimaryText(text: "1"),
                            ],
                          ),
                          Spaces.w32,
                          PrimaryButton(
                            text: "Replies",
                            textColor: AppColors.primary,
                            onPressed: () {
                              if (isLoggedIn) {
                                Routes.navigate(Routes.COMMENT_REPLIES,
                                    params: {
                                      ParameterKey.COMMENT_MODEL: comment,
                                      ParameterKey.VIDEO_RESPONSE:
                                          artistVideoResponse,
                                      ParameterKey.OTHER_ARTIST_PROFILE:
                                          artistProfileResponse
                                    });
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: PrimaryText(
                                      text: "Authentication Required!!!",
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                            color: AppColors.lightPink,
                            size: BUTTON_SIZE.small,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
