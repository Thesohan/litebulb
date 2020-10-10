import 'dart:core';

import 'package:new_artist_project/enums/enums.dart';

class AuditionModel {
  AuditionModel({
    this.images,
    this.auditionDate,
    this.postedBy,
    this.auditionCategory,
    this.auditionTitle,
    this.auditionLocation,
    this.auditionDescription,
    this.genderEnum,
    this.ageGroup,
    this.languages,
    this.expertise,
    this.tags,
    this.requiredArtists,
    this.auditionCallValidity,
    this.rollType,
    this.auditionType,
    this.budget,
  });

  final List<String> images;
  final String auditionDate;
  final String postedBy;
  final AuditionCategoryEnum auditionCategory;
  final String auditionTitle;
  final String auditionLocation;
  final String auditionDescription;
  final String genderEnum;
  final String ageGroup;
  final String languages;
  final List<String> expertise;
  final List<String> tags;
  final int requiredArtists;
  final String auditionCallValidity;
  final RoleTypeEnum rollType;
  final AuditionType auditionType;
  final double budget;
// final String auditionType

}
