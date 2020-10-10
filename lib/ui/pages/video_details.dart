import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neeko/neeko.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc_event.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'dart:math' as math;

import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/ui/widgets/input_tag.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_drop_down_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

typedef OnFinish = Function(String msg);

class BuildVideoDetails extends StatefulWidget {
  final File file;
  final OnFinish onFinish;

  const BuildVideoDetails(
      {Key key, @required this.file, @required this.onFinish})
      : assert(file != null && onFinish != null),
        super(key: key);
  @override
  BuildVideoDetailsState createState() {
    return BuildVideoDetailsState();
  }
}

class BuildVideoDetailsState extends State<BuildVideoDetails> {
  VideoBloc _videoBloc;
  TextEditingController _descriptionEditingController;
  TextEditingController _titleEditingController;
  VideoControllerWrapper _videoControllerWrapper;
  @override
  void didChangeDependencies() {
    _videoBloc = Provider.of<VideoBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _descriptionEditingController = TextEditingController();
    _titleEditingController = TextEditingController();
    _videoControllerWrapper =
        VideoControllerWrapper(DataSource.file(widget.file));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildVideoDetails(context),
    );
  }

  Widget _buildVideoDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        NeekoPlayerWidget(
          videoControllerWrapper: _videoControllerWrapper,
        ),
        Expanded(
          child: ListView(
            primary: true,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
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
                      : Icon(
                          Icons.camera_alt,
                          size: SizeConfig.safeBlockVertical * 8,
                        ),
                ),
              ),
              Expanded(
                child: PrimaryButton(
                  text: "Uplod Thumbnail",
                  size: BUTTON_SIZE.small,
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
                  highlightColor: AppColors.red,
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
        if (msg == "inserted") {
          widget.onFinish("Video details added successfully.");
        } else {
          widget.onFinish("Something Wnet Wrong!!!");
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
    _descriptionEditingController.dispose();
    _titleEditingController.dispose();
    super.dispose();
  }
}
