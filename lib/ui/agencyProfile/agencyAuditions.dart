import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class AgencyAuditions extends StatelessWidget {
  final AuditionBloc auditionBloc;
  final AgencyProfileResponse agencyProfileResponse;

  const AgencyAuditions(
      {Key key,
      @required this.auditionBloc,
      @required this.agencyProfileResponse})
      : assert(auditionBloc != null && agencyProfileResponse != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    auditionBloc.dispatch(
      FetchAgencyAuditionEvent(
        auditionRequest: AuditionRequest(
          user_id: agencyProfileResponse.id,
          agency_id: agencyProfileResponse.id,
          is_featured: '1',
        ),
      ),
    );
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: <Widget>[
        StreamBuilder<Resource<AuditionListResponse>>(
            stream: auditionBloc.activeAuditionBehaviourObservable,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.isSuccess) {
                return BuildAuditions(
                  isActive: true,
                  auditionList: snapshot.data.data.data,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SpinKitFadingCircle(
                    color: AppColors.red,
                  ),
                );
              }
            }),
        Spaces.h32,
        StreamBuilder<Resource<AuditionListResponse>>(
            stream: auditionBloc.inActiveAuditionBehaviourObservable,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.isSuccess) {
                return BuildAuditions(
                  isActive: false,
                  auditionList: snapshot.data.data.data,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SpinKitFadingCircle(
                    color: AppColors.red,
                  ),
                );
              }
            }),
        Spaces.h64,
      ],
    );
  }
}

class BuildAuditions extends StatelessWidget {
  const BuildAuditions({Key key, this.isActive, this.auditionList})
      : super(key: key);

  final bool isActive;
  final List<AuditionResponse> auditionList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        auditionList.length > 0
            ? PrimaryText(
                text: isActive ? "Active" : "Expired",
                color: AppColors.pink,
                fontSize: AppConstants.SUB_HEADING,
                fontWeight: FontWeight.bold,
              )
            : Container(),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: auditionList.length,
          itemBuilder: (context, index) {
            return _BuildAuditionItem(auditionModel: auditionList[index]);
          },
        ),
      ],
    );
  }
}

class _BuildAuditionItem extends StatelessWidget {
  final AuditionResponse auditionModel;

  const _BuildAuditionItem({Key key, this.auditionModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuditionBloc auditionBloc = Provider.of<AuditionBloc>(context);
    auditionBloc.dispatch(FetchCategoryEvent(id: auditionModel.category_id));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 14,
        child: InkWell(
          onTap: () {
            Routes.navigate(Routes.AUDITION_DETAIL_PAGE, params: {
              ParameterKey.AUDITION: auditionModel,
              ParameterKey.IS_ALREADY_APPLIED: false,
              ParameterKey.IS_ADDED_IN_WISHLIST: false,
            });
          },
          child: Card(
            elevation: AppConstants.CARD_ELEVATION,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: SizeConfig.safeBlockVertical * 14,
                  height: SizeConfig.safeBlockVertical * 14,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: auditionModel.post_url == null
                        ? Image.asset(
                            ImageAssets.DANCE,
                            width: SizeConfig.safeBlockVertical * 14,
                            height: SizeConfig.safeBlockVertical * 14,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            auditionModel.post_url,
                            width: SizeConfig.safeBlockVertical * 14,
                            height: SizeConfig.safeBlockVertical * 14,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Spaces.w16,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: PrimaryText(
                              maxLines: 1,
                              text: "${auditionModel.title}",
                              fontSize: AppConstants.NORMAL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RoundedButton(
                          text: "${auditionModel.validity.split(" ")[0]}",
                        ),
                        StreamBuilder<String>(
                            stream: auditionBloc.categoryBehaviourObservable,
                            builder: (context, snapshot) {
                              if (snapshot != null && snapshot.data != null) {
                                return RoundedButton(
                                  text: "${snapshot.data}",
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
