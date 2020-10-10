import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/aritst_bio_bloc_event.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/artist_bio_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class AddCreditPage extends StatefulWidget {
  final CreditModel artistCreditModel;

  const AddCreditPage({Key key, this.artistCreditModel}) : super(key: key);
  @override
  _AddCreditPageState createState() {
    return _AddCreditPageState();
  }
}

class _AddCreditPageState extends State<AddCreditPage> {
  ArtistBioBloc _bloc;
  @override
  void didChangeDependencies() {
    _bloc = Provider.of<ArtistBioBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (widget.artistCreditModel != null) {
      _awardNameTextEditingController.text =
          widget.artistCreditModel.award_name;
      _awardDetailsTextEditingController.text =
          widget.artistCreditModel.award_details;
      _roleTextEditingController.text = widget.artistCreditModel.role;
    }
    super.initState();
  }

  final GlobalKey<FormState> _formStateKey = new GlobalKey<FormState>();
  String _awardName;
  String _role;
  String _awardDetails;
  TextEditingController _awardNameTextEditingController =
      TextEditingController();
  TextEditingController _roleTextEditingController = TextEditingController();
  TextEditingController _awardDetailsTextEditingController =
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
                          text: "Credits",
                        ),
                        Spaces.h32,
                        PrimaryTextFormField(
                          textEditingController:
                              _awardNameTextEditingController,
                          title: "Award Name",
                          textInputType: TextInputType.text,
                          hintText: " + Add",
                          validator: (value) {
                            return value.isEmpty
                                ? "Award name can't be empty"
                                : null;
                          },
                          onSaved: (value) => _awardName = value,
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
                              _awardDetailsTextEditingController,
                          title: "Award Details",
                          textInputType: TextInputType.text,
                          hintText: " + Add",
                          validator: (value) => value.isEmpty
                              ? "Award Details can't be empty"
                              : null,
                          onSaved: (value) => _awardDetails = value,
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
                      _updateArtistCredits();
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
        text: "Credits",
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

  void _updateArtistCredits() {
    CreditModel updatedArtistCreditModel;
    if (widget.artistCreditModel == null) {
      //Todo(TheSohan) : pass artist id here
      updatedArtistCreditModel = CreditModel(
          award_details: _awardDetails,
          award_name: _awardName,
          role: _role,
          id: "5dcadb24b0d0e");
    } else {
      updatedArtistCreditModel = widget.artistCreditModel.copyWith(
          award_name: _awardName, role: _role, award_details: _awardDetails);
    }
    _bloc.dispatch(
      ArtistCreditUpdateEvent(
        artistCreditModel: updatedArtistCreditModel,
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
    _awardDetailsTextEditingController.dispose();
    _awardNameTextEditingController.dispose();
    super.dispose();
  }
}
