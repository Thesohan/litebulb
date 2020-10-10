import 'package:new_artist_project/blocs/base/baseEvent.dart';

class SignUpBlocEvent extends BaseEvent {
  final String email;
  final String password;
  final String whatsAppNumber;
  final String fullName;

  SignUpBlocEvent(
    this.email,
    this.password,
    this.whatsAppNumber,
    this.fullName,
  );

  @override
  String toString() {
    return "SignUpBlocEvent {email: $email,"
        "password: $password,"
        "whatsAppNumber: $whatsAppNumber,"
        "fullName: $fullName";
  }
}
