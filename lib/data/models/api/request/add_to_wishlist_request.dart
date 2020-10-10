import 'package:json_annotation/json_annotation.dart';

part 'add_to_wishlist_request.g.dart';

@JsonSerializable()
class AddToWishlistRequest {
  final String agencyid;
  final String artistid;
  final String postid;

  AddToWishlistRequest({this.agencyid, this.artistid, this.postid});

  factory AddToWishlistRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToWishlistRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToWishlistRequestToJson(this);

  AddToWishlistRequest copyWith(
      {String agencyid, String artistid, String postid}) {
    return AddToWishlistRequest(
      agencyid: agencyid ?? this.agencyid,
      postid: postid ?? this.postid,
      artistid: artistid ?? this.artistid,
    );
  }
}
