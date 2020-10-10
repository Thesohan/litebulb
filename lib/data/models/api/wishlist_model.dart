import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel {
  final String audition;
  final String vibe_user_id;
  final String post_id;
  final String added_on;
  final AuditionResponse auditionDetails;

  WishlistModel({
    this.audition,
    this.vibe_user_id,
    this.post_id,
    this.added_on,
    this.auditionDetails,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);
}
