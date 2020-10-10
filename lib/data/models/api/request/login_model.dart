import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String email;
  final String password;
  final String device_token;
  LoginModel({
    this.device_token,
    @required this.email,
    @required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
