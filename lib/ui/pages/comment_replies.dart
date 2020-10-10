import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:new_artist_project/data/models/api/request/comment_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/comment_request.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class CommentReplies extends StatefulWidget {
  const CommentReplies(
      {Key key,
      this.commentModel,
      this.artistProfileResponse,
      this.artistVideoResponse})
      : assert(commentModel != null),
        super(key: key);
  final CommentModel commentModel;
  final ArtistProfileResponse artistProfileResponse;
  final ArtistVideoResponse artistVideoResponse;

  @override
  _CommentRepliesState createState() {
    return _CommentRepliesState();
  }
}

class _CommentRepliesState extends State<CommentReplies> {
  TextEditingController _replyController;
  @override
  void initState() {
    _replyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoBloc videoBloc = Provider.of<VideoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: 'Replies',
          color: AppColors.white,
          fontSize: AppConstants.HEADING,
        ),
      ),
      body: _buildBody(context, videoBloc),
    );
  }

  Widget _buildBody(BuildContext context, VideoBloc videoBloc) {
    List<Replies> replies = [];
    widget.commentModel?.Replies?.forEach((reply) {
      List<String> replyModel = reply?.split('.');
      if(replyModel.length>=3){
        List<String> nameAndMsg = replyModel[2].split(":");
        String msg =
        nameAndMsg[1].trim().substring(1, nameAndMsg[1].trim().length - 1);
        Replies rep = Replies(
          artistOrAgency: replyModel[0].trim(),
          id: replyModel[1].trim(),
          replyMsg: msg,
          name: nameAndMsg[0].trim(),
        );
        replies.add(rep);
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            height: SizeConfig.safeBlockVertical * 16,
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.safeBlockVertical * 8),
                      child: widget.commentModel.profile_url != null
                          ? Image.network(
                              'https://${widget.commentModel.profile_url}',
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
                            text: "${widget.commentModel.Fullname}",
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.SUB_HEADING,
                            maxLines: 100,
                          ),
                          PrimaryText(
                            text: "${widget.commentModel.Message}",
                            maxLines: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryText(
            text: 'Replies',
            fontSize: AppConstants.HEADING,
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildReplyItem(
                replies: replies[index],
                commentModel: widget.commentModel,
              );
            },
            primary: true,
            itemCount: replies.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: PrimaryTextFormField(
                  maxLines: 2,
                  hintText: 'Enter your reply...',
                  textEditingController: _replyController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  text: "Reply",
                  onPressed: () {
                    videoBloc.dispatch(
                      AddCommentEvent(
                        addCommentModel: AddCommentModel(
                          object_id: widget.artistVideoResponse.video_id,
                          comment_id: widget.commentModel.comment_id,
                          sender_username:
                              widget.artistProfileResponse.username,
                          comment_text: _replyController.text,
                          visible: '1',
                          reply: '',
                          reply_id: widget.commentModel.comment_id,
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
                ),
              )
            ],
          ),
        )
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

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }
}

// ignore: camel_case_types
class _buildReplyItem extends StatelessWidget {
  final Replies replies;
  final CommentModel commentModel;

  const _buildReplyItem({Key key, this.replies, this.commentModel})
      : assert(replies != null && commentModel != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    VideoBloc videoBloc = Provider.of<VideoBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SpinKitFadingCircle(
                color: AppColors.red,
              );
            },
          );
          if (replies.artistOrAgency == 'Artist') {
            videoBloc.dispatch(
              FetchCommenterArtistProfileEvent(
                commenterProfileReqeust:
                    CommenterProfileRequest(user_id: replies.id),
                completer: _commenterProfileCompleter(context, isArtist: true),
              ),
            );
          } else if (replies.artistOrAgency == 'Agency') {
            videoBloc.dispatch(
              FetchCommenterAgencyProfileEvent(
                commenterProfileReqeust:
                CommenterProfileRequest(user_id: replies.id),
                completer: _commenterProfileCompleter(context, isArtist: true),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spaces.h8,
                PrimaryText(
                  text: "${replies.name}",
                  fontSize: AppConstants.SUB_HEADING,
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                  maxLines: 100,
                ),
                Spaces.h8,
                PrimaryText(
                  maxLines: 100,
                  text: "${replies.replyMsg}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Completer _commenterProfileCompleter(BuildContext context, {bool isArtist}) {
    return Completer()
      ..future.then((data) {
        Navigator.of(context).pop();
        if(isArtist){
          if(data=='LOGGED_IN_ARTIST'){
            Routes.navigate(Routes.ARTIST_PROFILE_PAGE,params:{ParameterKey.IS_LOGGED_IN:true});
          }
          else{
            Routes.navigate(Routes.ARTIST_PROFILE_PAGE,params:{ParameterKey.OTHER_ARTIST_PROFILE:data,ParameterKey.IS_LOGGED_IN:true});
          }
        }
        else{
          Routes.navigate(Routes.AGENCY_PROFILE_PAGE,params:{ParameterKey.AGENCY_PROFILE_RESPONSE:data,ParameterKey.IS_LOGGED_IN:true});
        }
      });
  }
}

class Replies {
  final String artistOrAgency;
  final String id;
  final String replyMsg;
  final String name;
  Replies(
      {@required this.artistOrAgency,
      @required this.id,
      @required this.replyMsg,
      @required this.name
      });
}
