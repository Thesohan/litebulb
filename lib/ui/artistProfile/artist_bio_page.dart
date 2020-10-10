import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/enums/enums.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';
import 'package:new_artist_project/ui/widgets/wrapped_list.dart';
import 'package:new_artist_project/util/size_config.dart';

class ArtistBio extends StatefulWidget {
  const ArtistBio(
      {Key key,
      this.isLoggedIn = false,
      this.bloc,
      this.otherArtistProfile,
      this.category})
      : super(key: key);
  final ArtistProfileBloc bloc;
  final ArtistProfileResponse otherArtistProfile;
  final String category;
  final bool isLoggedIn;

  @override
  _ArtistBioState createState() => _ArtistBioState();
}

class _ArtistBioState extends State<ArtistBio> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.otherArtistProfile == null) {
      widget.bloc.getLoggedInArtistProfile();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      // TODO(TheSohan) : if user haven't filled his/her info yet then show a centered icon with a click event redirecting him to add details, else show bio.
      body: widget.otherArtistProfile == null
          ? StreamBuilder<Resource<ArtistProfileResponse>>(
              stream: widget.bloc.artistBioResponseObservable,
              builder: (context, snapshot) {
                Resource<ArtistProfileResponse> res;
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data.data != null) {
                  res = snapshot.data;
                  ArtistProfileResponse artistProfileResponse = res.data;
                  if (res.isSuccess && artistProfileResponse != null)
                    return _buildBio(artistProfileResponse);
                } else if (res != null && res.isFailure) {
                  return Container();
                }
                return SpinKitFadingCircle(
                  color: AppColors.red,
                );
              },
            )
          : _buildBio(widget.otherArtistProfile),
    );
  }

  Widget _buildBio(ArtistProfileResponse artistProfileResponse) {
    return ListView(
      children: <Widget>[
        _buildAbout(artistProfileResponse),
        Spaces.h8,
        _buildOtherDetails(artistProfileResponse),
        Spaces.h8,
        _buildLocationAndCategory(
          artistProfileResponse.local,
          widget.otherArtistProfile != null
              ? widget.category
              : artistProfileResponse.category,
        ),
        Spaces.h8,
        _buildBodyDetails(artistProfileResponse),
        Spaces.h128,
      ],
    );
  }

  Widget _buildAbout(ArtistProfileResponse artistProfileResponse) {
    return artistProfileResponse.about != null && artistProfileResponse.about.trim().length>0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PrimaryText(
                      text: "About",
                      fontSize: AppConstants.SUB_HEADING,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pink,
                    ),
                    Spaces.h8,
                    PrimaryText(
                      text: artistProfileResponse.about ?? "",
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildOtherDetails(ArtistProfileResponse artistProfileResponse) {
    return artistProfileResponse.age != null ||
            artistProfileResponse.birthday != null ||
            artistProfileResponse.gender != null ||
            artistProfileResponse.language != null ||
            artistProfileResponse.skills != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        artistProfileResponse.age != null
                            ? Expanded(
                                child: TitleText(
                                    title: "Age",
                                    text: artistProfileResponse.age ?? ""),
                              )
                            : Container(),
                        artistProfileResponse.birthday != null
                            ? Expanded(
                                child: TitleText(
                                    title: "Birthday",
                                    text: artistProfileResponse.birthday ?? ""),
                              )
                            : Container(),
                      ],
                    ),
                    Spaces.h32,
                    artistProfileResponse.gender != null
                        ? TitleText(
                            title: "Gender",
                            text: artistProfileResponse.gender == '0' ||
                                    artistProfileResponse.gender == 'Male'
                                ? GenderEnum.Male.toString().split('.')[1]
                                : GenderEnum.Female.toString().split('.')[1],
                          )
                        : Container(),
                    Spaces.h32,
                    artistProfileResponse.language != null
                        ? PrimaryText(
                            text: "Language",
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.SUB_HEADING,
                            color: AppColors.pink,
                          )
                        : Container(),
                    Spaces.h8,
                    WrappedList(
                      items: artistProfileResponse.language != null
                          ? artistProfileResponse.language.split(',')
                          : [],
                    ),
                    Spaces.h32,
                    artistProfileResponse.skills != null
                        ? PrimaryText(
                            text: "Skills",
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.SUB_HEADING,
                            color: AppColors.pink,
                          )
                        : Container(),
                    Spaces.h8,
                    WrappedList(
                        items: artistProfileResponse.skills != null
                            ? artistProfileResponse.skills.split(',')
                            : []),
                    Spaces.h32,
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildLocationAndCategory(String location, String category) {
    return category != null || location != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    location != null && location.trim().length > 0
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PrimaryText(
                                text: "Location",
                                fontSize: AppConstants.SUB_HEADING,
                                color: AppColors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                              Spaces.h8,
                              PrimaryText(
                                maxLines: 2,
                                text: location ?? "",
                                fontWeight: FontWeight.normal,
                              ),
                              Spaces.h32,
                            ],
                          )
                        : Container(),
                    category != null && category.trim().length > 0
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PrimaryText(
                                text: "Category",
                                fontSize: AppConstants.SUB_HEADING,
                                color: AppColors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                              Spaces.h8,
                              PrimaryText(
                                maxLines: 1,
                                text: category ?? "",
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildBodyDetails(ArtistProfileResponse artistProfileResponse) {
    return artistProfileResponse.hips != null ||
            artistProfileResponse.skintone != null ||
            artistProfileResponse.height != null ||
            artistProfileResponse.butchest != null ||
            artistProfileResponse.waist != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: <Widget>[
                    artistProfileResponse.hips != null
                        ? _buildBodyItem(
                            "${artistProfileResponse.hips}", "Hips")
                        : Container(),
                    artistProfileResponse.hips != null
                        ? _buildBodyItem(
                            artistProfileResponse.skintone ?? "", "Skintone")
                        : Container(),
                    artistProfileResponse.hips != null
                        ? _buildBodyItem(
                            "${artistProfileResponse.height}", "Height")
                        : Container(),
                    artistProfileResponse.hips != null
                        ? _buildBodyItem(
                            "${artistProfileResponse.butchest}", "ButChest")
                        : Container(),
                    artistProfileResponse.hips != null
                        ? _buildBodyItem(
                            "${artistProfileResponse.waist}", "Waist")
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildBodyItem(String title, String text) {
    return title == null || title == "null"
        ? Container()
        : Container(
            width: SizeConfig.safeBlockVertical * 12,
            height: SizeConfig.safeBlockVertical * 12,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.lightPink,
              borderRadius:
                  BorderRadius.circular(SizeConfig.safeBlockVertical * 4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PrimaryText(
                  text: title,
                  fontSize: AppConstants.SUB_HEADING,
                  maxLines: 1,
                  fontWeight: FontWeight.w600,
                ),
                Spaces.h8,
                PrimaryText(
                  text: text,
                  color: AppColors.red,
                  fontSize: AppConstants.NORMAL,
                ),
              ],
            ),
          );
  }
}
