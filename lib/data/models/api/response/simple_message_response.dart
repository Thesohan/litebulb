import 'package:json_annotation/json_annotation.dart';

part 'simple_message_response.g.dart';

@JsonSerializable()
class SimpleMessageResponse {
  final String message;
  final String success;


  SimpleMessageResponse(this.message, this.success);

  factory SimpleMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMessageResponseToJson(this);
}
