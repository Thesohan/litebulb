import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';
import 'package:new_artist_project/ui/widgets/wrapped_list.dart';

class AgencyOwner extends StatelessWidget {
  final AgencyProfileResponse agencyProfileResponse;

  const AgencyOwner({Key key, @required this.agencyProfileResponse})
      : assert(agencyProfileResponse != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBio();
  }

  Widget _buildBio() {
    return ListView(
      children: <Widget>[
        _buildNameBirthdayGender(),
        Spaces.h8,
        _buildAbout(),
        Spaces.h8,
        _buildLocationAndWebsite(),
        Spaces.h128,
      ],
    );
  }

  Widget _buildNameBirthdayGender() {
    return Padding(
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
                  Expanded(
                    child: TitleText(
                        title: "Name", text: "${agencyProfileResponse.name}"),
                  ),
                  Expanded(
                    child: TitleText(
                        title: "Birthday",
                        text: "${agencyProfileResponse.dob}"),
                  ),
                ],
              ),
              Spaces.h32,
              TitleText(
                title: "Gender",
                text:
                    "${agencyProfileResponse.gender == '0' ? 'Male' : 'Female'}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return Padding(
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
                text: '${agencyProfileResponse.about_me}',
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAndWebsite() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              agencyProfileResponse.location != null
                  ? Column(
                      children: <Widget>[
                        PrimaryText(
                          text: "Location",
                          fontSize: AppConstants.SUB_HEADING,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pink,
                        ),
                        Spaces.h8,
                        PrimaryText(
                          maxLines: 2,
                          text: '${agencyProfileResponse.location}',
                          fontWeight: FontWeight.normal,
                        ),
                        Spaces.h32,
                      ],
                    )
                  : Container(),
              agencyProfileResponse.vk_url != null
                  ? Column(
                      children: <Widget>[
                        PrimaryText(
                          text: "Website",
                          fontSize: AppConstants.SUB_HEADING,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pink,
                        ),
                        Spaces.h8,
                        PrimaryText(
                          maxLines: 1,
                          text: '${agencyProfileResponse.vk_url}',
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
