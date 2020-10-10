import 'package:json_annotation/json_annotation.dart';
part 'artist_credit_model.g.dart';

@JsonSerializable()
class CreditModel {
  // ignore: non_constant_identifier_names
  final String p_id;
  final String id;
  // ignore: non_constant_identifier_names
  final String award_name;
  final String role;
  // ignore: non_constant_identifier_names
  final String award_details;

  CreditModel({
    // ignore: non_constant_identifier_names
    this.p_id,
    this.id,
    // ignore: non_constant_identifier_names
    this.award_name,
    this.role,
    // ignore: non_constant_identifier_names
    this.award_details,
  });

  CreditModel copyWith({
    String p_id,
    String id,
    String award_name,
    String role,
    String award_details,
  }) {
    return CreditModel(
        p_id: p_id ?? this.p_id,
        id: id ?? this.id,
        award_name: award_name ?? this.award_name,
        role: role ?? this.role,
        award_details: award_details ?? this.award_details);
  }

  factory CreditModel.fromJson(Map<String, dynamic> json) =>
      _$CreditModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditModelToJson(this);
}
