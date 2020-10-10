import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/audition_model.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class BuildAuditionList extends StatelessWidget {
  const BuildAuditionList({
    Key key,
    @required this.auditionList,
    this.isLoggedIn = false,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final List<AuditionResponse> auditionList;
  final Axis scrollDirection;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 40,
      child: ListView.builder(
        scrollDirection: this.scrollDirection,
        shrinkWrap: true,
        itemCount: auditionList.length,
        itemBuilder: (context, index) {
          return _BuildAuditionItem(
            audition: auditionList[index],
            isLoggedIn: isLoggedIn,
          );
        },
      ),
    );
  }
}

class _BuildAuditionItem extends StatelessWidget {
  const _BuildAuditionItem({
    Key key,
    this.audition,
    this.isLoggedIn = false,
  }) : super(key: key);

  final AuditionResponse audition;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    AuditionBloc _auditionBloc = Provider.of<AuditionBloc>(context);
    return InkWell(
      onTap: () {
        Routes.navigate(Routes.AUDITION_DETAIL_PAGE, params: {
          ParameterKey.AUDITION: audition,
        }).whenComplete(() {
          _auditionBloc.dispatch(
            FetchFeaturedAuditionBlocEvent(
              auditionRequest: AuditionRequest(agency_id: "All",
                   is_featured: '1',),
            ),
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: SizeConfig.safeBlockVertical * 30,
          child: Card(
            elevation: AppConstants.CARD_ELEVATION,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: audition.image_url != null
                      ? Image.network(
                          "https://${audition.image_url.split(',').toList()[0]}",
                          width: SizeConfig.safeBlockVertical * 30,
                          height: SizeConfig.safeBlockVertical * 30,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          ImageAssets.DANCE,
                          width: SizeConfig.safeBlockVertical * 30,
                          height: SizeConfig.safeBlockVertical * 30,
                          fit: BoxFit.cover,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: PrimaryText(
                      text: "${audition.title}",
                      fontSize: AppConstants.SUB_HEADING,
                      maxLines: 1,
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
