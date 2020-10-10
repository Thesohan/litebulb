import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/artists/build_artist_experience_list.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:provider/provider.dart';

class AgencyProject extends StatelessWidget {
  final Logger _logger = Logger('AgencyProject');
  final AgencyProfileResponse agencyProfileResponse;

  AgencyProject({Key key, @required this.agencyProfileResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AgencyProfileBloc agencyProfileBloc =
        Provider.of<AgencyProfileBloc>(context);
    agencyProfileBloc.dispatch(
      FetchAgencyExpOrCredEvent(
        value: 'projects',
        id: '1',
      ),
    );
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
              stream: agencyProfileBloc.agencyProjectResponseObservable,
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
                          artistExperienceModelList:
                              expSnapshot?.data?.data?.data,
                        ),
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
      ],
    );
  }
}
