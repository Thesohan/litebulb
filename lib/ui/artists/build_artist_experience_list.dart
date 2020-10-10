import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/artist_experience_model.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';

class BuildArtistExperienceList extends StatelessWidget {
  final List<ArtistExperienceModel> artistExperienceModelList;
  final bool isLoggedInArtist;
  const BuildArtistExperienceList(
      {Key key,
      @required this.artistExperienceModelList,
      this.isLoggedInArtist = false})
      : assert(artistExperienceModelList != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => _BuildArtistExperienceItem(
        artistExperienceModel: artistExperienceModelList[index],
        isLoggedInArtist: isLoggedInArtist,
      ),
      separatorBuilder: (context, index) => PrimaryDivider(),
      itemCount: artistExperienceModelList.length,
    );
  }
}

class _BuildArtistExperienceItem extends StatelessWidget {
  final ArtistExperienceModel artistExperienceModel;
  final bool isLoggedInArtist;
  const _BuildArtistExperienceItem({
    Key key,
    @required this.artistExperienceModel,
    this.isLoggedInArtist,
  })  : assert(artistExperienceModel != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoggedInArtist) {
          Routes.navigate(
            Routes.ADD_EXPERIENCE_PAGE,
            params: {
              ParameterKey.ARTIST_EXPERIENCE_MODEL: artistExperienceModel
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryText(
                  text: artistExperienceModel.project_name,
                  color: AppColors.red,
                  fontSize: AppConstants.SUB_HEADING,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                ),
                PrimaryText(
                  text: artistExperienceModel.role,
                  fontSize: AppConstants.NORMAL,
                  maxLines: 1,
                ),
                PrimaryText(
                  fontSize: AppConstants.SMALL,
                  maxLines: 2,
                  text: artistExperienceModel.project_details,
                ),
              ],
            ),
            isLoggedInArtist
                ? Icon(
                    Icons.edit,
                    color: AppColors.red,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
