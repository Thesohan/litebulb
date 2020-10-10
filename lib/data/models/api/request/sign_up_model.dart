import 'package:json_annotation/json_annotation.dart';
part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  final String email;
  final String password;
  final String whatsAppNumber;
  final String fullName;

  SignUpModel(
    this.email,
    this.password,
    this.whatsAppNumber,
    this.fullName,
  );

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
