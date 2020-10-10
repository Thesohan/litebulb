import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/request/register_artist_request.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void didChangeDependencies() {
    _authenticationBloc = Provider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }

  AuthenticationBloc _authenticationBloc;

  String _email;
  String _password;
  String _whatsAppNumber;
  String _fullName;
  String _confirmPassword;
  TextEditingController _passwordTextEditingController;
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        Center(
          child: InkWell(
            onTap: () {
              Routes.navigate(Routes.HOME_PAGE);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: (18),
                fontFamily: 'Montserrat.Regular',
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 12,
            ),
            onPressed: null)
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Spaces.h24,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 96.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(ImageAssets.APPICON),
                  ),
                ),
              ),
              Spaces.h24,
              Form(
                key: this._formStateKey,
                child: Column(
                  children: <Widget>[
                    PrimaryTextFormField(
                      hintText: "Full Name",
                      icon: Icon(Icons.person),
                      onSaved: (value) {
                        _fullName = value;
                      },
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return value.isEmpty ? "Please enter full name." : null;
                      },
                    ),
                    Spaces.h32,
                    PrimaryTextFormField(
                      hintText: "Whats App Number",
                      icon: Icon(Icons.call),
                      onSaved: (value) {
                        _whatsAppNumber = value;
                      },
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return value.isEmpty
                            ? "Please enter your whatsApp number."
                            : null;
                      },
                    ),
                    Spaces.h32,
                    PrimaryTextFormField(
                      hintText: "Email",
                      icon: Icon(Icons.email),
                      onSaved: (value) {
                        _email = value;
                      },
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return value.isEmpty
                            ? "Please enter your email."
                            : null;
                      },
                    ),
                    Spaces.h32,
                    PrimaryTextFormField(
                      textEditingController: _passwordTextEditingController,
                      hintText: "Password",
                      icon: Icon(Icons.lock),
                      onSaved: (value) {
                        _password = value;
                      },
                      isObscure: true,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        _passwordTextEditingController.text = value;
                        return value.isEmpty
                            ? "Please enter your password."
                            : null;
                      },
                    ),
                    Spaces.h32,
                    PrimaryTextFormField(

                      hintText: "Confirm Password",
                      icon: Icon(Icons.lock),
                      isObscure: true,
                      onSaved: (value) {
                        _confirmPassword = value;
                      },
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        print(
                            "$value, ${_passwordTextEditingController.text},$_password");
                        if (value.isEmpty) {
                          return "Please enter your password.";
                        } else if (value ==
                            _passwordTextEditingController.text) {
                          return null;
                        }
                        return "Password unmatched.";
                      },
                    ),
                  ],
                ),
              ),
              Spaces.h32,
              PrimaryButton(
                text: "SIGN UP",
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
                    _authenticationBloc.dispatch(RegisterArtistEvent(
                      registerArtistRequest: RegisterArtistRequest(
                        username: _fullName,
                        email: _email,
                        number: _whatsAppNumber,
                        password: _password,
                      ),
                      completer: _registerCompleter(),
                    ));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Completer _registerCompleter({bool shouldPop = true}) {
    return Completer()
      ..future.then(
        (msg) {
          /// popping dialog
          if (shouldPop) {
            Navigator.of(context).pop();
          }
          if (msg == 'true') {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(days: 1),
                behavior: SnackBarBehavior.fixed,
                content: PrimaryText(
                    text:
                        "Please confirm your email address by clicking the confirmation link sent to your email.",
                    color: AppColors.white),
                action: SnackBarAction(
                  label: "Ok",
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
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
