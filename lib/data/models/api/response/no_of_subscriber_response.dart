import 'package:json_annotation/json_annotation.dart';

part 'no_of_subscriber_response.g.dart';

@JsonSerializable()
class NoOfSubscriberResponse {
  final String message;
  final String success;
  final int data;

  NoOfSubscriberResponse({this.message, this.success, this.data,});


  factory NoOfSubscriberResponse.fromJson(Map<String, dynamic> json) =>
      _$NoOfSubscriberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoOfSubscriberResponseToJson(this);
}
