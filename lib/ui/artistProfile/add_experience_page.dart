import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/aritst_bio_bloc_event.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/artist_bio_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class AddExperiencePage extends StatefulWidget {
  final ArtistExperienceModel artistExperienceModel;

  const AddExperiencePage({Key key, this.artistExperienceModel})
      : super(key: key);
  @override
  _AddExperiencePageState createState() {
    return _AddExperiencePageState();
  }
}

class _AddExperiencePageState extends State<AddExperiencePage> {
  ArtistBioBloc _bloc;
  @override
  void didChangeDependencies() {
    _bloc = Provider.of<ArtistBioBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (widget.artistExperienceModel != null) {
      _projectNameTextEditingController.text =
          widget.artistExperienceModel.project_name;
      _projectDetailsTextEditingController.text =
          widget.artistExperienceModel.project_details;
      _roleTextEditingController.text = widget.artistExperienceModel.role;
    }
    super.initState();
  }

  final GlobalKey<FormState> _formStateKey = new GlobalKey<FormState>();
  String _projectName;
  String _role;
  String _projectDetails;
  TextEditingController _projectNameTextEditingController =
      TextEditingController();
  TextEditingController _roleTextEditingController = TextEditingController();
  TextEditingController _projectDetailsTextEditingController =
      TextEditingController();

  bool _validateAndSave() {
    final form = _formStateKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 0.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: AppConstants.CARD_ELEVATION,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: this._formStateKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PrimaryText(
                          text: "EXPERIENCE",
                        ),
                        Spaces.h32,
                        PrimaryTextFormField(
                          textEditingController:
                              _projectNameTextEditingController,
                          title: "Project Name",
                          textInputType: TextInputType.text,
                          hintText: " + Add",
                          validator: (value) {
                            return value.isEmpty
                                ? "Project name can't be empty"
                                : null;
                          },
                          onSaved: (value) => _projectName = value,
                        ),
                        Spaces.h32,
                        PrimaryTextFormField(
                          textEditingController: _roleTextEditingController,
                          title: "Role",
                          textInputType: TextInputType.text,
                          hintText: " + Add",
                          validator: (value) =>
                              value.isEmpty ? "Role can't be empty" : null,
                          onSaved: (value) => _role = value,
                        ),
                        Spaces.h32,
                        PrimaryTextFormField(
                          textEditingController:
                              _projectDetailsTextEditingController,
                          title: "Project Details",
                          textInputType: TextInputType.text,
                          hintText: " + Add",
                          validator: (value) => value.isEmpty
                              ? "Project Details can't be empty"
                              : null,
                          onSaved: (value) => _projectDetails = value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spaces.h64,
              Center(
                child: PrimaryButton(
                  text: "Done",
                  onPressed: () {
                    if (_validateAndSave()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return SpinKitFadingCircle(
                            color: AppColors.red,
                          );
                        },
                      );
                      _updateArtistExperience();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: PrimaryText(
        text: "Experience",
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _updateArtistExperience() {
    ArtistExperienceModel updatedArtistExperienceModel;
    if (widget.artistExperienceModel == null) {
      //Todo(TheSohan) : pass artist id here
      updatedArtistExperienceModel = ArtistExperienceModel(
          project_details: _projectDetails,
          project_name: _projectName,
          role: _role,
          id: "5dcadb24b0d0e");
    } else {
      updatedArtistExperienceModel = widget.artistExperienceModel.copyWith(
          project_name: _projectName,
          role: _role,
          project_details: _projectDetails);
    }
    _bloc.dispatch(
      ArtistExperienceUpdateEvent(
        artistExperienceModel: updatedArtistExperienceModel,
        completer: Completer()
          ..future.then((data) {
            /// popping dialog
            Navigator.of(context).pop();
            if (data.status == Status.success) {
              /// popping add artist bio page.

              Navigator.of(context).pop();
            }
          }),
      ),
    );
  }

  @override
  void dispose() {
    _roleTextEditingController.dispose();
    _projectDetailsTextEditingController.dispose();
    _projectNameTextEditingController.dispose();
    super.dispose();
  }
}
