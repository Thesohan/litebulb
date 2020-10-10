import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/request/forgot_password_request.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';
import 'home/homePage.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AuthenticationBloc _authenticationBloc;

  @override
  void didChangeDependencies() {
    _authenticationBloc = Provider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  String _email;
  final GlobalKey<FormState> _formStateKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            Spaces.h64,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(ImageAssets.APPICON),
                    ),
                  ),
                ),
                Spaces.h64,
                Form(
                  key: this._formStateKey,
                  child: Column(
                    children: <Widget>[
                      PrimaryTextFormField(
                        textInputType: TextInputType.emailAddress,
                        icon: Icon(Icons.email),
                        hintText: "Email Address",
                        validator: (value) => value.isEmpty
                            ? "Email Address can't be empty"
                            : null,
                        onSaved: (value) => _email = value,
                      ),
                      Spaces.h32,
                    ],
                  ),
                ),
                Spaces.h32,
                PrimaryButton(
                  text: "Forgot Password",
                  onPressed: () {
                    if (_validateAndSave()) {
                      FocusScope.of(context).unfocus();
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
                        ForgotPasswordEvent(
                          forgotPasswordRequest:
                              ForgotPasswordRequest(email: this._email),
                          completer: _forgotPasswordCompleter(),
                        ),
                      );
                    }
                  },
                ),
                Spaces.h32,
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Completer _forgotPasswordCompleter({bool shouldPop = true}) {
    return Completer()
      ..future.then(
        (msg) {
          /// popping dialog
          if (shouldPop) {
            Navigator.of(context).pop();
          }
          if (msg == 'true') {
            Navigator.of(context).pop();
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Something Went Wrong!!!"),
              ),
            );
          }
        },
      );
  }
}
