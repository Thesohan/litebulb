import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc_event.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc.dart';
import 'package:new_artist_project/blocs/loginBloc/authentication_bloc_event.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/request/category_id.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

import 'home/homePage.dart';

class LoginPage extends StatefulWidget {
  final bool isAlreadyLogin;

  const LoginPage({
    Key key,
    this.isAlreadyLogin = false,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationBloc _loginBloc;
  GlobalBloc _globalBloc;
  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<AuthenticationBloc>(context);
    _globalBloc = Provider.of<GlobalBloc>(context);
    _globalBloc.dispatch(
      CategoryBlocEvent(
        categoryRequest: IdRequest(id: 'All'),
      ),
    );
    _globalBloc.dispatch(
      FetchRoleTypeListEvent(
        roleRequest: IdRequest(id: 'All'),
      ),
    );

    super.didChangeDependencies();
  }


  @override
  String _email;
  String _password;
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
      appBar: _buildAppBar(),
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
                      PrimaryTextFormField(
                        textInputType: TextInputType.visiblePassword,
                        icon: Icon(Icons.lock),
                        isObscure: true,
                        hintText: "Password",
                        validator: (value) =>
                            value.isEmpty ? "Password can't be empty" : null,
                        onSaved: (value) => _password = value,
                      ),
                    ],
                  ),
                ),
                Spaces.h32,
                PrimaryButton(
                  text: "LOGIN",
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
                      _loginBloc.dispatch(
                        LoginBlocEvent(
                          email: this._email,
                          password: this._password,
                          completer: _loginCompleter(),
                        ),
                      );
                    }
                  },
                ),
                Spaces.h32,
                new Center(
                  child: ClickableText(
                    onPressed: () {
                      Routes.navigate(Routes.FORGOT_PASSWORD_PAGE);
                    },
                    text: "Forgot Password",
                  ),
                ),
                Spaces.h32,
                RichText(
                  text: TextSpan(
                    text: "New to LiteBulb? ",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Montserrat.Regular',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'SignUp Here',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Montserrat.Regular',
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Routes.navigate(Routes.SIGN_UP_PAGE);
                          },
                      ),
                    ],
                  ),
                ),
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

  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        InkWell(
          onTap: () => Routes.navigate(Routes.HOME_PAGE,
              params: {ParameterKey.IS_LOGGED_IN: false}),
          child: Center(
            child: Row(
              children: <Widget>[
                PrimaryText(
                  text: 'Skip',
                  color: AppColors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Completer _loginCompleter({bool shouldPop = true}) {
    return Completer()
      ..future.then(
        (msg) {
          /// popping dialog
          if (shouldPop) {
            Navigator.of(context).pop();
          }
          if (msg == 'Logged in') {
            _replacePage();
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("$msg"),
              ),
            );
          }
        },
      );
  }

  /// Created this method as loginPage was always rebuilding due to some kind of inherited widget while fetching audition list in homepage.
  void _replacePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            Provider<AllArtistBloc>(
              create: (context) => AllArtistBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AuditionBloc>(
              create: (context) => AuditionBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AgencyProfileBloc>(
              create: (context) => AgencyProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<GlobalBloc>(
              create: (context) => GlobalBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<ArtistProfileBloc>(
              create: (context) => ArtistProfileBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<VideoBloc>(
              create: (context) => VideoBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}
