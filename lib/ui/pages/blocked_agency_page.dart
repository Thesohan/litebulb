import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_agency_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/agency/buildAgencyList.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:provider/provider.dart';

class BlockedAgencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AgencyProfileBloc agencyProfileBloc  = Provider.of<AgencyProfileBloc>(context);
    agencyProfileBloc.dispatch(FetchBlockedAgencyEvent());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder<Resource<AllAgencyProfileResponse>>(
        stream: agencyProfileBloc.blockedAgencyResponseObservable,
        builder: (context, snapshot) {
          if(snapshot!=null && snapshot.data!=null && snapshot.data.data!=null){
            List<AgencyProfileResponse> blockedAgencies = snapshot.data.data.data;
            return _buildBody(blockedAgencies);
          }
          else{
            return SpinKitFadingCircle(
              color: AppColors.red,
            );
          }
        }
      ),
    );
  }

  Widget _buildBody(List<AgencyProfileResponse> blockedAgencies) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
            bottom: 16.0,
            left: 32.0,
          ),
          child: PrimaryText(
            text: "Blocked Agencies",
            fontSize: AppConstants.HEADING,
            fontWeight: FontWeight.bold,
          ),
        ),
        BuildAgencyList(
          agencyList: blockedAgencies,
          isBlocked: true,
        )
      ],
    );
  }
}
