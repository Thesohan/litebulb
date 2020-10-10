import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/data/resource.dart';

class ArtistBioUpdateEvent extends BaseEvent {
  final ArtistProfileResponse artistProfileResponse;
  final Completer<Resource<SimpleMessageResponse>> completer;
  ArtistBioUpdateEvent(
      {@required this.artistProfileResponse, @required this.completer});

  @override
  String toString() {
    return "ArtistBioUpdateEvent{artistProfileResponse:$artistProfileResponse}";
  }
}

class ArtistExperienceUpdateEvent extends BaseEvent {
  final ArtistExperienceModel artistExperienceModel;
  final Completer<Resource<SimpleMessageResponse>> completer;

  ArtistExperienceUpdateEvent({
    @required this.artistExperienceModel,
    @required this.completer,
  });

  @override
  String toString() {
    return "ArtistExperienceUpdateEvent{artistExperienceModel:$artistExperienceModel}";
  }
}

class ArtistCreditUpdateEvent extends BaseEvent {
  final CreditModel artistCreditModel;
  final Completer<Resource<SimpleMessageResponse>> completer;

  ArtistCreditUpdateEvent(
      {@required this.artistCreditModel, @required this.completer});

  @override
  String toString() {
    return "ArtistCreditUpdateEvent{artistCreditModel:$artistCreditModel}";
  }
}

class UpdateGenderDropDown extends BaseEvent {
  final String gender;

  UpdateGenderDropDown({@required this.gender}) : assert(gender != null);

  @override
  String toString() {
    return 'UpdateGenderDropDown{gender:$gender';
  }
}

class RemoveLanguageTag extends BaseEvent {
  final String language;

  RemoveLanguageTag({this.language}) : assert(language != null);
  @override
  String toString() {
    return 'RemoveLanguageTag{language:$language}';
  }
}

class AddLanguageTag extends BaseEvent {
  final String language;

  AddLanguageTag({@required this.language}) : assert(language != null);
  @override
  String toString() {
    return 'AddLanguageTag{language:$language}';
  }
}

class UpdateLanguageTags extends BaseEvent {
  final Set<String> languages;

  UpdateLanguageTags({@required this.languages}) : assert(languages != null);

  @override
  String toString() {
    return 'UpdateLanguageTags{languages:$languages}';
  }
}

class RemoveSkillTag extends BaseEvent {
  final String skill;

  RemoveSkillTag({this.skill}) : assert(skill != null);
  @override
  String toString() {
    return 'RemoveSkillTag{language:$skill}';
  }
}

class AddSkillTag extends BaseEvent {
  final String skill;

  AddSkillTag({@required this.skill}) : assert(skill != null);
  @override
  String toString() {
    return 'AddSkillTag{language:$skill}';
  }
}

class UpdateSkillTags extends BaseEvent {
  final Set<String> skills;

  UpdateSkillTags({@required this.skills}) : assert(skills != null);

  @override
  String toString() {
    return 'UpdateSkillTags{languages:$skills}';
  }
}

class UpdateBirthdayEvent extends BaseEvent {
  final String birthday;

  UpdateBirthdayEvent({@required this.birthday});

  @override
  String toString() {
    return 'UpdateBirthdayEvent{birthday:$birthday}';
  }
}

class UpdateCategoryEvent extends BaseEvent {
  final String category;

  UpdateCategoryEvent({@required this.category});

  @override
  String toString() {
    return 'UpdateCategoryEvent{category:$category}';
  }
}
