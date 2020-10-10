import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_exp_or_cred_request.g.dart';

@JsonSerializable()
class ExpOrCred {
  final String value;
  final String id;

  ExpOrCred({@required this.value, @required this.id})
      : assert(value != null && id != null);

  factory ExpOrCred.fromJson(Map<String, dynamic> json) =>
      _$ExpOrCredFromJson(json);
  Map<String, dynamic> toJson() => _$ExpOrCredToJson(this);
}
