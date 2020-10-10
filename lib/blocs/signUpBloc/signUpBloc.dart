import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/blocs/signUpBloc/signUpBlocEvent.dart';
import 'package:new_artist_project/data/models/api/request/sign_up_model.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc<SignUpBlocEvent> {
  BehaviorSubject<SignUpModel> _signUpModelBehaviorSubject =
      BehaviorSubject<SignUpModel>();

  @override
  void handleEvent(SignUpBlocEvent event) {
    // TODO: implement handleEvent
    if (event is SignUpBlocEvent) {
      print(event.toString());
    }
  }

  void init() {
    // TODO: implement init
  }

  @override
  void dispose() {
    super.dispose();
    _signUpModelBehaviorSubject.close();
  }
}
