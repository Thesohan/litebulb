import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class BuildAgencyList extends StatelessWidget {
  const BuildAgencyList({
    Key key,
    @required this.agencyList,
    this.isBlocked = false,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final List<AgencyProfileResponse> agencyList;
  final Axis scrollDirection;
  final bool isBlocked;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      scrollDirection: this.scrollDirection,
      itemBuilder: (context, index) {
        return _BuildAgencyItem(
          agency: agencyList[index],
          isBlocked: this.isBlocked,
        );
      },
      separatorBuilder: (context, index) {
        return PrimaryDivider(
          leftPadding: 8.0,
          rightPadding: 8.0,
        );
      },
      itemCount: agencyList.length,
    );
  }
}

class _BuildAgencyItem extends StatelessWidget {
  const _BuildAgencyItem({
    Key key,
    this.agency,
    this.isBlocked = false,
  }) : super(key: key);

  final bool isBlocked;
  final AgencyProfileResponse agency;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBlocked
          ? SizeConfig.safeBlockVertical * 16
          : SizeConfig.safeBlockVertical * 14,
      child: InkWell(
        onTap: () {
          Routes.navigate(Routes.AGENCY_PROFILE_PAGE,
              params: {ParameterKey.AGENCY_PROFILE_RESPONSE: agency});
        },
        child: Card(
          elevation: AppConstants.CARD_ELEVATION,
          child: Row(
            mainAxisAlignment: isBlocked
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildImage(isBlocked),
              Spaces.w8,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: PrimaryText(
                          maxLines: 2,
                          text: "${agency.name}",
                          fontSize: AppConstants.SUB_HEADING,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: PrimaryText(
                          text: "${agency.location}",
                          maxLines: 2,
                        ),
                      ),
                      isBlocked
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PrimaryButton(
                                  text: "Unblock",
                                  onPressed: () {
                                    AgencyProfileBloc agencyProfileBloc =
                                        Provider.of<AgencyProfileBloc>(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return SpinKitFadingCircle(
                                          color: AppColors.red,
                                        );
                                      },
                                    );
                                    agencyProfileBloc.dispatch(
                                      BlockOrUnBlockAgencyEvent(
                                        isBlocEvent: false,
                                        agencyId: agency.id,
                                        completer: _completer(context),
                                      ),
                                    );
                                  },
                                  size: BUTTON_SIZE.small,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              isBlocked ? Container() : Spaces.w8,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(bool isBlocked) {
    if (isBlocked) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 14),
        child: agency.avatar_loc == null
            ? Image.asset(
                ImageAssets.DANCE,
                width: SizeConfig.safeBlockVertical * 14,
                height: SizeConfig.safeBlockVertical * 14,
                fit: BoxFit.cover,
              )
            : Image.network(
                "https://${agency.avatar_loc}",
                width: SizeConfig.safeBlockVertical * 14,
                height: SizeConfig.safeBlockVertical * 14,
                fit: BoxFit.cover,
              ),
      );
    } else {
      return Container(
        width: SizeConfig.safeBlockVertical * 14,
        height: SizeConfig.safeBlockVertical * 14,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: agency.avatar_loc == null
              ? Image.asset(
                  ImageAssets.DANCE,
                  width: SizeConfig.safeBlockVertical * 14,
                  height: SizeConfig.safeBlockVertical * 14,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  "https://${agency.avatar_loc}",
                  width: SizeConfig.safeBlockVertical * 14,
                  height: SizeConfig.safeBlockVertical * 14,
                  fit: BoxFit.cover,
                ),
        ),
      );
    }
  }

  Completer _completer(BuildContext context) {
    return Completer()
      ..future.then(
        (msg) {
          /// popping dialog
          Navigator.of(context).pop();
          if (msg == 'Removed from blocked list') {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: PrimaryText(
                  text: "$msg",
                  color: AppColors.white,
                ),
              ),
            );
          }
        },
      );
  }
}
