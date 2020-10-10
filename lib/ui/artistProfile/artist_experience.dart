import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/artists/build_artist_experience_list.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

class Experience extends StatelessWidget {
  Experience(
      {Key key,
      this.artistProfileBloc,
      this.otherArtistProfile,
      this.isLoggedIn = false})
      : super(key: key);
  final Logger _logger = Logger('Experience');
  final ArtistProfileBloc artistProfileBloc;
  final ArtistProfileResponse otherArtistProfile;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    if (otherArtistProfile == null) {
      artistProfileBloc.dispatch(FetchArtistExperienceFromPref());
    } else {
      artistProfileBloc.dispatch(
        FetchOtherArtistExpOrCredEvent(
          value: 'experience',
          id: this.otherArtistProfile.id,
        ),
      );
    }
    return ListView(
      children: <Widget>[
        SizedBox(
          height: (50),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: StreamBuilder<Resource<ExpOrProResponse>>(
              stream: artistProfileBloc.artistExperienceObservable,
              builder: (context, expSnapshot) {
                if (expSnapshot.hasData &&
                    expSnapshot.data != null &&
                    expSnapshot.data.isSuccess &&
                    expSnapshot.data.data != null) {
                  return Card(
                    elevation: AppConstants.CARD_ELEVATION,
                    child: Column(
                      children: <Widget>[
                        BuildArtistExperienceList(
                          isLoggedInArtist: otherArtistProfile == null,
                          artistExperienceModelList:
                              expSnapshot?.data?.data?.data,
                        ),
                        StreamBuilder<bool>(
                            initialData: true,
                            stream:
                                artistProfileBloc.isShowAllPressedObservable,
                            builder: (context, showAllSnapshot) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClickableText(
                                  fontSize: AppConstants.SUB_HEADING,
                                  fontWeight: FontWeight.bold,
                                  text: showAllSnapshot.data == false &&
                                          expSnapshot.data.data.data.length < 2
                                      ? 'Show All + '
                                      : 'Show Less - ',
                                  onPressed: () {
                                    artistProfileBloc.dispatch(
                                      UpdateShowAllPressStatus(
                                        isExperience: true,
                                        isShowAllPressed:
                                            showAllSnapshot.data ? false : true,
                                        isOtherArtist:
                                            otherArtistProfile == null
                                                ? false
                                                : true,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                }
                return SpinKitFadingCircle(
                  color: AppColors.red,
                );
              }),
        ),
        SizedBox(
          height: (40),
        ),
        otherArtistProfile == null && isLoggedIn
            ? Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Center(
                  child: Card(
                    elevation: AppConstants.CARD_ELEVATION,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          PrimaryText(
                            text: "Add your Experience",
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.lightPink,
                            radius: 24,
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Routes.navigate(Routes.ADD_EXPERIENCE_PAGE);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
