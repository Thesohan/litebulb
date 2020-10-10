import 'package:json_annotation/json_annotation.dart';
part 'audition_response.g.dart';

@JsonSerializable()
class AuditionResponse {
  final String id;
  // ignore: non_constant_identifier_names
  final String lang_id;
  final String title;
  // ignore: non_constant_identifier_names
  final String title_slug;
  final String location;
  final String gender;
  // ignore: non_constant_identifier_names
  final String age_group;
  final String expertise;
  // ignore: non_constant_identifier_names
  final String artist_required;
  // ignore: non_constant_identifier_names
  final String role_id;
  // ignore: non_constant_identifier_names
  final String is_paid;
  final String budget;
  final String keywords;
  final String summary;
  final String content;
  // ignore: non_constant_identifier_names
  final String category_id;
  // ignore: non_constant_identifier_names
  final String subcategory_id;
  // ignore: non_constant_identifier_names
  final String file_name;
  // ignore: non_constant_identifier_names
  final String file_size;
  // ignore: non_constant_identifier_names
  final String file_type;
  // ignore: non_constant_identifier_names
  final String image_default;
  // ignore: non_constant_identifier_names
  final String image_big;
  // ignore: non_constant_identifier_names
  final String image_slider;
  // ignore: non_constant_identifier_names
  final String image_mid;
  // ignore: non_constant_identifier_names
  final String image_small;
  final String hit;
  // ignore: non_constant_identifier_names
  final String need_auth;
  // ignore: non_constant_identifier_names
  final String is_slider;
  // ignore: non_constant_identifier_names
  final String slider_order;
  // ignore: non_constant_identifier_names
  final String is_featured;
  // ignore: non_constant_identifier_names
  final String featured_order;
  // ignore: non_constant_identifier_names
  final String is_recommended;
  // ignore: non_constant_identifier_names
  final String is_breaking;
  final String visibility;
  // ignore: non_constant_identifier_names
  final String show_right_coloumn;
  // ignore: non_constant_identifier_names
  final String post_type;
  // ignore: non_constant_identifier_names
  final String video_path;
  // ignore: non_constant_identifier_names
  final String image_url;
  // ignore: non_constant_identifier_names
  final String video_embed_code;
  // ignore: non_constant_identifier_names
  final String user_id;
  final String status;
  // ignore: non_constant_identifier_names
  final String feed_id;
  // ignore: non_constant_identifier_names
  final String post_url;
  // ignore: non_constant_identifier_names
  final String show_post_url;
  // ignore: non_constant_identifier_names
  final String image_description;
  // ignore: non_constant_identifier_names
  final String created_at;
  final String validity;
  final String languages;
  final String optional_url;
  final String agency_name;
  final String is_addedtowishlist;
  final String is_invited;
  final is_applied;
  AuditionResponse({
    this.languages,
    this.id,
    // ignore: non_constant_identifier_names
    this.lang_id,
    this.title,
    // ignore: non_constant_identifier_names
    this.title_slug,
    this.location,
    this.gender,
    // ignore: non_constant_identifier_names
    this.age_group,
    this.expertise,
    // ignore: non_constant_identifier_names
    this.artist_required,
    // ignore: non_constant_identifier_names
    this.role_id,
    // ignore: non_constant_identifier_names
    this.is_paid,
    this.budget,
    this.keywords,
    this.summary,
    this.content,
    // ignore: non_constant_identifier_names
    this.category_id,
    // ignore: non_constant_identifier_names
    this.subcategory_id,
    // ignore: non_constant_identifier_names
    this.file_name,
    // ignore: non_constant_identifier_names
    this.file_size,
    // ignore: non_constant_identifier_names
    this.file_type,
    // ignore: non_constant_identifier_names
    this.image_default,
    // ignore: non_constant_identifier_names
    this.image_big,
    // ignore: non_constant_identifier_names
    this.image_slider,
    // ignore: non_constant_identifier_names
    this.image_mid,
    // ignore: non_constant_identifier_names
    this.image_small,
    this.hit,
    // ignore: non_constant_identifier_names
    this.need_auth,
    // ignore: non_constant_identifier_names
    this.is_slider,
    // ignore: non_constant_identifier_names
    this.slider_order,
    // ignore: non_constant_identifier_names
    this.is_featured,
    // ignore: non_constant_identifier_names
    this.featured_order,
    // ignore: non_constant_identifier_names
    this.is_recommended,
    // ignore: non_constant_identifier_names
    this.is_breaking,
    this.visibility,
    // ignore: non_constant_identifier_names
    this.show_right_coloumn,
    // ignore: non_constant_identifier_names
    this.post_type,
    // ignore: non_constant_identifier_names
    this.video_path,
    // ignore: non_constant_identifier_names
    this.image_url,
    // ignore: non_constant_identifier_names
    this.video_embed_code,
    // ignore: non_constant_identifier_names
    this.user_id,
    this.status,
    // ignore: non_constant_identifier_names
    this.feed_id,
    // ignore: non_constant_identifier_names
    this.post_url,
    // ignore: non_constant_identifier_names
    this.show_post_url,
    // ignore: non_constant_identifier_names
    this.image_description,
    // ignore: non_constant_identifier_names
    this.created_at,
    this.validity,
    // ignore: non_constant_identifier_names
    this.optional_url,
    this.agency_name,
    this.is_addedtowishlist,
    this.is_invited,
    this.is_applied,
  });

  factory AuditionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuditionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuditionResponseToJson(this);
}
