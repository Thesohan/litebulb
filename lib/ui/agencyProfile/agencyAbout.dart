import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/artists/build_credit_list.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/wrapped_list.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgencyAbout extends StatelessWidget {
  final AgencyProfileResponse agencyProfileResponse;
  final AuditionBloc auditionBloc;

  const AgencyAbout({
    Key key,
    @required this.agencyProfileResponse,
    this.auditionBloc,
  })  : assert(agencyProfileResponse != null && auditionBloc != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final AgencyProfileBloc agencyProfileBloc =
        Provider.of<AgencyProfileBloc>(context);
    auditionBloc
        .dispatch(FetchCategoryEvent(id: agencyProfileResponse.category));
    agencyProfileBloc.dispatch(
      FetchAgencyExpOrCredEvent(value: 'credits', id: "1"),
    );
    return ListView(
      children: <Widget>[
        _buildAbout(),
        _buildCategories(),
        _buildCredits(agencyProfileBloc),
        _buildSocialMediaLink(),
      ],
    );
  }

  Widget _buildAbout() {
    return agencyProfileResponse.about_me != null
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
                      text: "About Company",
                      fontSize: AppConstants.SUB_HEADING,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pink,
                    ),
                    Spaces.h8,
                    PrimaryText(
                      text: '${agencyProfileResponse.about_me}',
                      fontWeight: FontWeight.normal,
                    ),
                    Spaces.h32,
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: StreamBuilder<String>(
              stream: auditionBloc.categoryBehaviourObservable,
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.data != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PrimaryText(
                        text: "Category",
                        color: AppColors.pink,
                        fontSize: AppConstants.SUB_HEADING,
                        fontWeight: FontWeight.bold,
                      ),
                      Spaces.h8,
                      WrappedList(
                        textColor: AppColors.white,
                        backgroundColor: AppColors.red,
                        items: ['${snapshot.data}'],
                      ),
                      Spaces.h32,
                    ],
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }

  Widget _buildCredits(AgencyProfileBloc agencyProfileBloc) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: StreamBuilder<Resource<CredResponse>>(
          stream: agencyProfileBloc.agencyCreditResponseObservable,
          builder: (context, credSnapshot) {
            if (credSnapshot.hasData &&
                credSnapshot.data != null &&
                credSnapshot.data.isSuccess &&
                credSnapshot.data.data != null) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PrimaryText(
                      text: "Credits",
                      fontSize: AppConstants.HEADING,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    elevation: AppConstants.CARD_ELEVATION,
                    child: Column(
                      children: <Widget>[
                        Spaces.h8,
                        BuildCreditList(
                          isLoggedInArtist: false,
                          creditModelList: credSnapshot?.data?.data?.data,
                        ),
                        Spaces.h8,
                      ],
                    ),
                  ),
                ],
              );
            }
            return SpinKitFadingCircle(
              color: AppColors.red,
            );
          }),
    );
  }

  Widget _buildSocialMediaLink() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16.0,
        children: <Widget>[
          agencyProfileResponse.google_url != null
              ? IconButton(
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: AppColors.red,
                  ),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.google_url}"));
                  },
                )
              : Container(),
          agencyProfileResponse.facebook_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.facebook, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.facebook_url}"));
                  },
                )
              : null,
          agencyProfileResponse.linkedin_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.linkedinIn, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.linkedin_url}"));
                  },
                )
              : Container(),
          agencyProfileResponse.pinterest_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.pinterest, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.pinterest_url}"));
                  },
                )
              : Container(),
          agencyProfileResponse.instagram_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.instagram, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.instagram_url}"));
                  },
                )
              : Container(),
          agencyProfileResponse.twitter_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.twitter, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.twitter_url}"));
                  },
                )
              : Container(),
          agencyProfileResponse.youtube_url != null
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.youtube, color: AppColors.red),
                  onPressed: () {
                    auditionBloc.dispatch(LaunchUrlEvent(
                        url: "${agencyProfileResponse.youtube_url}"));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
