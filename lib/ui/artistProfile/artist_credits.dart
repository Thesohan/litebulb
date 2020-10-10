import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/artists/build_credit_list.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

class Credits extends StatelessWidget {
  Credits(
      {Key key,
      this.artistProfileBloc,
      this.otherArtistProfile,
      this.isLoggedIn = false})
      : super(key: key);

  final ArtistProfileBloc artistProfileBloc;
  final bool isLoggedIn;
  final ArtistProfileResponse otherArtistProfile;
  final Logger _logger = Logger('Credits');

  @override
  Widget build(BuildContext context) {
    if (otherArtistProfile == null) {
      artistProfileBloc.dispatch(FetchArtistCreditsFromPref());
    } else {
      artistProfileBloc.dispatch(
        FetchOtherArtistExpOrCredEvent(
          value: 'credits',
          id: otherArtistProfile.id,
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
          child: StreamBuilder<Resource<CredResponse>>(
              stream: artistProfileBloc.artistCredResponseObservable,
              builder: (context, credSnapshot) {
                if (credSnapshot!=null &&
                    credSnapshot.data != null &&
                    credSnapshot.data.data != null) {
                  CredResponse credRes = credSnapshot.data.data;
                  return Card(
                    elevation: AppConstants.CARD_ELEVATION,
                    child: Column(
                      children: <Widget>[
                        BuildCreditList(
                          isLoggedInArtist: otherArtistProfile == null,
                          creditModelList: credSnapshot?.data?.data?.data,
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
                                          credSnapshot.data.data.data.length < 2
                                      ? 'Show All + '
                                      : 'Show Less - ',
                                  onPressed: () {
                                    artistProfileBloc.dispatch(
                                      UpdateShowAllPressStatus(
                                        isExperience: false,
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
                            text: "Add your Credit",
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
                                Routes.navigate(Routes.ADD_CREDITS_PAGE);
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
