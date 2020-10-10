import 'package:json_annotation/json_annotation.dart';
import 'package:new_artist_project/data/models/api/wishlist_model.dart';
part 'artist_wishlist_response.g.dart';

@JsonSerializable()
class ArtistWishlistResponse {
  final List<WishlistModel> data;

  ArtistWishlistResponse(this.data);

  factory ArtistWishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistWishlistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistWishlistResponseToJson(this);
}
