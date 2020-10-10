import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/aritst_bio_bloc_event.dart';
import 'package:new_artist_project/blocs/artist_bio_bloc/artist_bio_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc.dart';
import 'package:new_artist_project/blocs/global_bloc/global_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/category_list_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/enums/enums.dart';
import 'package:new_artist_project/ui/widgets/input_tag.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_drop_down_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class AddArtistBioPage extends StatefulWidget {
  @override
  _AddArtistBioPageState createState() {
    return _AddArtistBioPageState();
  }
}

class _AddArtistBioPageState extends State<AddArtistBioPage> {
  ArtistBioBloc _artistBioBloc;
  GlobalBloc _categoryBloc;

  @override
  void didChangeDependencies() {
    _artistBioBloc = Provider.of<ArtistBioBloc>(context);
    _categoryBloc = Provider.of<GlobalBloc>(context);
    _categoryBloc.dispatch(GetCategoryEvent());
    super.didChangeDependencies();
  }

  final GlobalKey<FormState> _formStateKey = new GlobalKey<FormState>();
  final Logger _logger = Logger('AddArtistBioPage');
  String _name;
  String _about;
  String _skills;
  String _age;
  String _languages;
  String _gender;
  String _birthday;
  String _skintone;
  String _hips;
  String _height;
  String _butchest;
  String _waist;
  String _category;
  String _location;

  TextEditingController _nameTextEditingController = TextEditingController();

  TextEditingController _aboutTextEditingController = TextEditingController();
  TextEditingController _ageTextEditingController = TextEditingController();
  TextEditingController _languagesTextEditingController =
      TextEditingController();
  TextEditingController _skintoneTextEditingController =
      TextEditingController();
  TextEditingController _hipsTextEditingController = TextEditingController();
  TextEditingController _heightTextEditingController = TextEditingController();
  TextEditingController _butchestTextEditingController =
      TextEditingController();
  TextEditingController _waistTextEditingController = TextEditingController();
  TextEditingController _locationTextEditingController =
      TextEditingController();

  bool _validateAndSave() {
    final form = _formStateKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
//    _artistBioBloc.init();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: StreamBuilder<ArtistProfileResponse>(
            stream: _artistBioBloc.artistProfileResponseObservable,
            builder: (context, snapshot) {
              ArtistProfileResponse artistProfileResponse;
              if (snapshot.hasData && snapshot.data != null) {
                artistProfileResponse = snapshot.data;
                _updateControllersWithArtistData(artistProfileResponse);
                return Column(
                  children: <Widget>[
                    Form(
                      key: this._formStateKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Name",
                              textInputType: TextInputType.text,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Name can't be empty"
                                    : null;
                              },
                              textEditingController:
                              _nameTextEditingController,
                              onSaved: (value) => _name = value,
                            ),
                          ),
                          Spaces.h16,

                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "About",
                              maxChar: 400,
                              textInputType: TextInputType.emailAddress,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "About can't be empty"
                                    : null;
                              },
                              textEditingController:
                                  _aboutTextEditingController,
                              onSaved: (value) => _about = value,
                            ),
                          ),
                          Spaces.h8,
                          _buildSkills(),
                          Spaces.h16,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Age",
                              textEditingController: _ageTextEditingController,
                              textInputType: TextInputType.number,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Age can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _age = value,
                            ),
                          ),
                          Spaces.h16,
                          _buildLanguage(),
                          Spaces.h16,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: _buildGenderDropDown(),
                          ),
                          Spaces.h24,
                          ..._buildBirthday(),
                          Spaces.h16,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Skintone",
                              textEditingController:
                                  _skintoneTextEditingController,
                              textInputType: TextInputType.emailAddress,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Skintone can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _skintone = value,
                            ),
                          ),
                          Spaces.h16,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Hips",
                              textEditingController: _hipsTextEditingController,
                              textInputType: TextInputType.emailAddress,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Hips can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _hips = value,
                            ),
                          ),
                          Spaces.h16,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Height",
                              textInputType: TextInputType.emailAddress,
                              hintText: " + Add",
                              textEditingController:
                                  _heightTextEditingController,
                              validator: (value) {
                                return value.isEmpty
                                    ? "Height can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _height = value,
                            ),
                          ),
                          Spaces.h32,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Butchest",
                              textEditingController:
                                  _butchestTextEditingController,
                              textInputType: TextInputType.text,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Butchest can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _butchest = value,
                            ),
                          ),
                          Spaces.h32,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Waist",
                              textEditingController:
                                  _waistTextEditingController,
                              textInputType: TextInputType.text,
                              hintText: " + Add",
                              validator: (value) {
                                return value.isEmpty
                                    ? "Waist can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _waist = value,
                            ),
                          ),
                          Spaces.h32,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: _buildCategory(),
                          ),
                          Spaces.h32,
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PrimaryTextFormField(
                              title: "Location",
                              textInputType: TextInputType.emailAddress,
                              hintText: " + Add",
                              textEditingController:
                                  _locationTextEditingController,
                              validator: (value) {
                                return value.isEmpty
                                    ? "Location can't be empty"
                                    : null;
                              },
                              onSaved: (value) => _location = value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spaces.h64,
                    Center(
                      child: PrimaryButton(
                        text: "Done",
                        onPressed: () {
                          if (_validateAndSave()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return SpinKitFadingCircle(
                                  color: AppColors.red,
                                );
                              },
                            );
                            _updateArtistProfile(artistProfileResponse);
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: AppColors.red,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: PrimaryText(
        text: "Add Bio",
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _updateControllersWithArtistData(
    ArtistProfileResponse artistProfileResponse,
  ) {
    if (artistProfileResponse == null) {
      return;
    }
    _nameTextEditingController.text = artistProfileResponse.name;
    _aboutTextEditingController.text = artistProfileResponse.about;
    _skills = artistProfileResponse.skills;
    if (_skills != null) {
      _artistBioBloc.dispatch(
        UpdateSkillTags(
          skills: _skills.split(',').toSet(),
        ),
      );
    }
    _languages = artistProfileResponse.language;
    if (_languages != null) {
      _artistBioBloc.dispatch(
        UpdateLanguageTags(
          languages: _languages.split(',').toSet(),
        ),
      );
    }
    _gender = artistProfileResponse.gender;
    if(_gender!=null){
      _artistBioBloc.dispatch(
        UpdateGenderDropDown(gender: _gender),
      );
    }
    _ageTextEditingController.text = artistProfileResponse.age;
    _languagesTextEditingController.text = artistProfileResponse.language;
    _birthday = artistProfileResponse.birthday;
    if(_birthday!=null){
      _artistBioBloc.dispatch(
        UpdateBirthdayEvent(
          birthday: _birthday,
        ),
      );
    }
    _skintoneTextEditingController.text = artistProfileResponse.skintone;
    _hipsTextEditingController.text = artistProfileResponse.hips;
    _heightTextEditingController.text = artistProfileResponse.height;
    _butchestTextEditingController.text = artistProfileResponse.butchest;
    _waistTextEditingController.text = artistProfileResponse.waist;
    _category = artistProfileResponse.category;
    _locationTextEditingController.text = artistProfileResponse.local;
  }

  void _updateArtistProfile(ArtistProfileResponse oldArtistProfileResponse) {
    ArtistProfileResponse artistProfileResponse = ArtistProfileResponse(
      name: _name,
      username: oldArtistProfileResponse.username,
      id: oldArtistProfileResponse.id,
      about: _about,
      age: _age,
      birthday: _birthday,
      gender: _gender,
      is_subscribed: '0',
      is_addedtowishlist: '0',
      ///update languages before calling api in bloc.
      language: _languages,

      ///update skills before calling api in bloc.
      skills: _skills,
      local: _location,

      /// Update category before calling api in bloc
      category: _category,
      hips: _hips,
      skintone: _skintone,
      height: _height,
      butchest: _butchest,
      waist: _waist,
    );
    _artistBioBloc.dispatch(
      ArtistBioUpdateEvent(
        artistProfileResponse: artistProfileResponse,
        completer: Completer()
          ..future.then(
            (data) {
              /// popping dialog
              Navigator.of(context).pop();
              if (data.status == Status.success) {
                /// popping add artist bio page.
                Navigator.of(context).pop();
              }
            },
          ),
      ),
    );
  }

  Widget _buildCategory() {
    return StreamBuilder<CategoryListModel>(
      stream: _categoryBloc.categoryObservable,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          CategoryListModel categoryListModel = snapshot.data;
          List<String> categoryList = categoryListModel.categoryList
              .map((category) => category.name)
              .toList();
          return PrimaryDropDownButton(
            title: "Category",
            dropDownMenuItems: categoryList,
            onChange: (value) {
              _artistBioBloc.dispatch(
                UpdateCategoryEvent(category: value),
              );
              _categoryBloc.dispatch(
                UpdateCategoryDropDownValue(
                  categoryListModel: CategoryListModel(
                    categoryList: categoryListModel.categoryList,
                    value: value,
                  ),
                ),
              );
            },
            value: categoryListModel.value,
            itemBuilder: (context, index, isSelected) {
              return PrimaryText(
                text: categoryListModel.categoryList[index].name,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildGenderDropDown() {
    return StreamBuilder<String>(
        stream: _artistBioBloc.genderObservable,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            return PrimaryDropDownButton(
              title: "Gender",
              dropDownMenuItems: GenderEnum.values
                  .map((gender) => gender.toString().split('.')[1])
                  .toList(),
              onChange: (value) {
                _artistBioBloc.dispatch(
                  UpdateGenderDropDown(gender: value),
                );
              },
              value: snapshot.data == '1' || snapshot.data == 'Female'
                  ? "Female"
                  : "Male",
              itemBuilder: (context, index, isSelected) {
                return PrimaryText(
                  text: GenderEnum.values[index].toString().split('.')[1],
                );
              },
            );
          } else
            return Container();
        });
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _aboutTextEditingController.dispose();
    _ageTextEditingController.dispose();
    _skintoneTextEditingController.dispose();
    _hipsTextEditingController.dispose();
    _heightTextEditingController.dispose();
    _butchestTextEditingController.dispose();
    _waistTextEditingController.dispose();
    _locationTextEditingController.dispose();

    super.dispose();
  }

  Widget _buildLanguage() {
    return StreamBuilder<Set<String>>(
        stream: _artistBioBloc.languageObservable,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryText(
                  text: "Language",
                ),
                InputTags(
                  duplicate: false,
                  autofocus: false,
                  tags: snapshot.data.toList(),
                  color: AppColors.red,
                  fontSize: 14.0,
                  onDelete: (language) {
                    _artistBioBloc.dispatch(
                      RemoveLanguageTag(language: language),
                    );
                  },
                  onInsert: (language) {
                    _artistBioBloc.dispatch(
                      AddLanguageTag(language: language),
                    );
                  },
                  alignment: MainAxisAlignment.start,
                  inputDecoration: InputDecoration(
                    hintText: "Add a language",
                  ),
                ),
              ],
            );
          } else
            return Container();
        });
  }

  Widget _buildSkills() {
    return StreamBuilder<Set<String>>(
        stream: _artistBioBloc.skillObservable,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            Set<String> updatedSkills = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryText(
                  text: "Skills",
                ),
                InputTags(
                  duplicate: false,
                  autofocus: false,
                  highlightColor: AppColors.red,
                  tags: updatedSkills.toList(),
                  color: AppColors.red,
                  fontSize: 14.0,
                  onDelete: (skill) {
                    _artistBioBloc.dispatch(
                      RemoveSkillTag(skill: skill),
                    );
                  },
                  onInsert: (skill) {
                    _artistBioBloc.dispatch(
                      AddSkillTag(skill: skill),
                    );
                  },
                  alignment: MainAxisAlignment.start,
                  inputDecoration: InputDecoration(
                    hintText: 'Add a Skill',
                  ),
                ),
              ],
            );
          } else
            return Container();
        });
  }

  List<Widget> _buildBirthday() {
    return [
      PrimaryText(
        text: "Birthday",
      ),
      Spaces.h8,
      InkWell(
        onTap: () async {
          final updatedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (BuildContext context, Widget child) {
              return child;
            },
          ).then((date) => date.toIso8601String().split('T')[0]);
          _artistBioBloc.dispatch(
            UpdateBirthdayEvent(
              birthday: updatedDate,
            ),
          );
          _birthday = updatedDate;
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<String>(
                  stream: _artistBioBloc.birthdayObservable,
                  builder: (context, snapshot) {
                    if (snapshot != null && snapshot.data != null) {
                      return PrimaryText(
                        text: snapshot.data,
                        color: AppColors.hintColor,
                      );
                    } else {
                      return PrimaryText(
                        text: "+ Add",
                        color: AppColors.hintColor,
                      );
                    }
                  }),
              Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
      PrimaryDivider(
        leftPadding: 0.0,
        topPadding: 0,
        color: AppColors.red,
      )
    ];
  }
}
