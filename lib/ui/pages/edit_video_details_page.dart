import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neeko/neeko.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/ui/widgets/input_tag.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_drop_down_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class EditVideoDetailsPage extends StatefulWidget {
  final ArtistVideoResponse artistVideoResponse;

  const EditVideoDetailsPage({
    Key key,
    this.artistVideoResponse,
  })  : assert(artistVideoResponse != null),
        super(key: key);

  @override
  BuildEditVideoDetailsState createState() {
    return BuildEditVideoDetailsState();
  }
}

class BuildEditVideoDetailsState extends State<EditVideoDetailsPage> {
  VideoBloc _videoBloc;
  TextEditingController _descriptionEditingController;
  TextEditingController _titleEditingController;
  VideoControllerWrapper _videoControllerWrapper;
  VideoControllerWrapper _newVideoControllerWrapper;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    _videoBloc = Provider.of<VideoBloc>(context);
    _videoBloc.dispatch(UpdateSafeAudienceEvent(
        safeValue: widget.artistVideoResponse.is_safe == '1'));
    _videoBloc.dispatch(UpdatePublicAudienceEvent(
        publicValue: widget.artistVideoResponse.is_public == '1'));
    Set<String> tags = widget.artistVideoResponse.tags?.split(',')?.toSet();
    _videoBloc.dispatch(UpdateTagEvent(tags: tags));
    _videoBloc.dispatch(UpdateCategoryDropDownValueEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _descriptionEditingController = TextEditingController();
    _titleEditingController = TextEditingController();
    if (widget.artistVideoResponse != null) {
      _descriptionEditingController.text =
          widget.artistVideoResponse.description;
      _titleEditingController.text = widget.artistVideoResponse.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _videoControllerWrapper = VideoControllerWrapper(
      DataSource.network("${widget.artistVideoResponse.location}"),
    );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: PrimaryText(
          text: 'Edit Video Details',
          fontSize: AppConstants.HEADING,
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: _buildVideoDetails(context),
      ),
    );
  }

  Widget _buildVideoDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<File>(
            stream: _videoBloc.videoFileObservable,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.data != null) {
                _newVideoControllerWrapper =
                    VideoControllerWrapper(DataSource.file(snapshot.data));
                return NeekoPlayerWidget(
                  videoControllerWrapper: _newVideoControllerWrapper,
                );
              } else {
                return NeekoPlayerWidget(
                  videoControllerWrapper: _videoControllerWrapper,
                );
              }
            }),
        Expanded(
          child: ListView(
            primary: true,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              _replaceVideo(),
              Spaces.h16,
              _buildTitle(),
              Spaces.h16,
              _buildCategory(),
              Spaces.h16,
              _buildAudience(),
              Spaces.h16,
              _buildDescription(),
              Spaces.h16,
              _buildTags(),
              Spaces.h16,
              _buildUploadThumbnail(),
              Spaces.h64,
              PrimaryButton(
                text: "Submit",
                size: BUTTON_SIZE.large,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return SpinKitFadingCircle(
                        color: AppColors.red,
                      );
                    },
                  );
                  _videoBloc.dispatch(
                    UploadVideoDetailsEvent(
                      description: _descriptionEditingController.text,
                      title: _titleEditingController.text,
                      videoId: widget.artistVideoResponse.video_id,
                      completer: _buildCompleter(),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAudience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PrimaryText(
          text: "Audience",
        ),
        Spaces.h8,
        StreamBuilder<bool>(
            stream: _videoBloc.safeObservable,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.data != null) {
                return Row(
                  children: <Widget>[
                    PrimaryText(
                      text: "Safe",
                    ),
                    Switch(
                      value: snapshot.data,
                      onChanged: (value) {
                        _videoBloc.dispatch(
                            UpdateSafeAudienceEvent(safeValue: value));
                      },
                      activeColor: AppColors.pink,
                      inactiveThumbColor: AppColors.green,
                    )
                  ],
                );
              } else {
                return Container();
              }
            }),
        Spaces.h8,
        StreamBuilder<bool>(
            stream: _videoBloc.publicObservable,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.data != null) {
                return Row(
                  children: <Widget>[
                    PrimaryText(
                      text: "Public",
                    ),
                    Switch(
                      value: snapshot.data,
                      onChanged: (value) {
                        _videoBloc.dispatch(
                            UpdatePublicAudienceEvent(publicValue: value));
                      },
                      activeColor: AppColors.pink,
                      inactiveThumbColor: AppColors.green,
                    )
                  ],
                );
              } else {
                return Container();
              }
            }),
        PrimaryDivider(
          leftPadding: 0.0,
          rightPadding: 0.0,
        )
      ],
    );
  }

  Widget _buildUploadThumbnail() {
    return StreamBuilder<File>(
        stream: _videoBloc.thumbnailFileObservable,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: SizeConfig.safeBlockVertical * 16,
                  height: SizeConfig.safeBlockVertical * 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.lightPink,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: snapshot.data != null
                      ? Image.file(
                          snapshot.data,
                          width: SizeConfig.safeBlockVertical * 8,
                          height: SizeConfig.safeBlockVertical * 8,
                          fit: BoxFit.fill,
                        )
                      : widget.artistVideoResponse.thumbnail_url != null
                          ? Image.network(
                              '${widget.artistVideoResponse.thumbnail_url}',
                              width: SizeConfig.safeBlockVertical * 8,
                              height: SizeConfig.safeBlockVertical * 8,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: SizeConfig.safeBlockVertical * 8,
                            ),
                ),
              ),
              Expanded(
                child: PrimaryButton(
                  text: "Uplod Thumbnail",
                  size: BUTTON_SIZE.medium,
                  onPressed: () {
                    _videoBloc.dispatch(PickThumbnailEvent());
                  },
                ),
              )
            ],
          );
        });
  }

  Widget _buildTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: PrimaryTextFormField(
            title: "Hours",
            textInputType: TextInputType.visiblePassword,
            hintText: "00",
//          validator: (value) => value.isEmpty ? "Role can't be empty" : null,
//            onSaved: (value) => _role = value,
          ),
        ),
        Spaces.w64,
        Flexible(
          flex: 1,
          child: PrimaryTextFormField(
            title: "Mins",
            textInputType: TextInputType.visiblePassword,
            hintText: "00",
//   validator: (value) => value.isEmpty ? "Role can't be empty" : null,
//            onSaved: (value) => _role = value,
          ),
        ),
        Spaces.w64,
        Flexible(
          flex: 1,
          child: PrimaryTextFormField(
            title: "Sec",
            textInputType: TextInputType.visiblePassword,
            hintText: "00",
//   validator: (value) => value.isEmpty ? "Role can't be empty" : null,
//            onSaved: (value) => _role = value,
          ),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return StreamBuilder<CategoryListModel>(
      stream: _videoBloc.categoryObservable,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          CategoryListModel categoryListModel = snapshot.data;
          List<String> categoryList = categoryListModel.categoryList
              .map((category) => category.name)
              .toList();
          categoryList
              .forEach((c) => print("$c **\n ${categoryListModel.value}"));
          return PrimaryDropDownButton(
            title: "Category",
            dropDownMenuItems: categoryList,
            onChange: (value) {
              _videoBloc.dispatch(
                UpdateCategoryDropDownValueEvent(
                  categoryListModel: CategoryListModel(
                    categoryList: categoryListModel.categoryList,
                    value: value,
                  ),
                ),
              );
            },
            value: categoryListModel.value,
            itemBuilder: (context, index, isSelected) {
              return PrimaryText(
                text: categoryListModel.categoryList[index].name,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildTags() {
    return StreamBuilder<Set<String>>(
        stream: _videoBloc.tagObservable,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            Set<String> updatedTags = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryText(
                  text: "Tags",
                ),
                InputTags(
                  duplicate: false,
                  autofocus: false,
                  tags: updatedTags.toList(),
                  color: AppColors.red,
                  fontSize: 14.0,
                  onDelete: (String tag) {
                    _videoBloc.dispatch(
                      RemoveTagEvent(tag: tag),
                    );
                  },
                  onInsert: (String tag) {
                    _videoBloc.dispatch(
                      AddTagEvent(tag: tag),
                    );
                  },
                  alignment: MainAxisAlignment.start,
                  inputDecoration: InputDecoration(
                    hintText: 'Add a tag',
                  ),
                ),
              ],
            );
          } else
            return Container();
        });
  }

  Widget _buildDescription() {
    return PrimaryTextFormField(
      title: "Description",
      textEditingController: _descriptionEditingController,
      textInputType: TextInputType.emailAddress,
      hintText: " + Add",
      maxChar: 120,
    );
  }

  Completer _buildCompleter() {
    return Completer()
      ..future.then((msg) {
        /// popping dialog
        Navigator.of(context).pop();
        if (msg == "updated") {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: PrimaryText(
                text: "Video details updated.",
                color: AppColors.white,
              ),
            ),
          );
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: PrimaryText(
                text: "$msg.",
                color: AppColors.white,
              ),
            ),
          );
        }
      });
  }

  Widget _buildTitle() {
    return PrimaryTextFormField(
      title: "Title",
      textEditingController: _titleEditingController,
      textInputType: TextInputType.emailAddress,
      hintText: " + Add",
      maxChar: 120,
    );
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    _videoControllerWrapper.dispose();
    _newVideoControllerWrapper.dispose();
    super.dispose();
  }

  Widget _replaceVideo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
            text: 'Choose Video',
            onPressed: () {
              _videoBloc.dispatch(
                ChooseVideoEvent(),
              );
            }),
      ),
    );
  }
}
