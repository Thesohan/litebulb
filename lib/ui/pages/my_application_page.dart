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
import 'package:new_artist_project/data/models/api/response/applied_audition_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/applied_audition_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class MyApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuditionBloc _auditionBloc = Provider.of<AuditionBloc>(context);
    _auditionBloc.dispatch(FetchAppliedAuditionEvent());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PrimaryText(
                text: "My Application",
                fontSize: AppConstants.SUB_HEADING,
                fontWeight: FontWeight.bold,
              ),
              StreamBuilder<Resource<List<AppliedAuditionModel>>>(
                  stream:
                      _auditionBloc.appliedAuditionResponseBehaviourObservable,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.data != null &&
                        snapshot.data.isSuccess) {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          return _BuildMyApplicationItem(
                            appliedAuditionModel: snapshot.data.data[index],
                          );
                        },
                      );
                    } else {
                      return SpinKitFadingCircle(
                        color: AppColors.red,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildMyApplicationItem extends StatelessWidget {
  final AppliedAuditionModel appliedAuditionModel;

  const _BuildMyApplicationItem({Key key, this.appliedAuditionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuditionResponse auditionResponse = appliedAuditionModel.auditionDetails;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Routes.navigate(Routes.AUDITION_DETAIL_PAGE, params: {
            ParameterKey.AUDITION: auditionResponse,
          });
        },
        child: Card(
          elevation: AppConstants.CARD_ELEVATION,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.safeBlockVertical * 12),
                      child: auditionResponse.image_url != null
                          ? Image.network(
                              "https://${auditionResponse.image_url.split(',').toList()[0]}",
                              width: SizeConfig.safeBlockVertical * 12,
                              height: SizeConfig.safeBlockVertical * 12,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              ImageAssets.DANCE,
                              width: SizeConfig.safeBlockVertical * 12,
                              height: SizeConfig.safeBlockVertical * 12,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Spaces.w8,
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PrimaryText(
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            text: "${auditionResponse.title} ",
                          ),
                          Spaces.h4,
                          PrimaryText(
                            maxLines: 3,
                            color: AppColors.grayText,
                            text: "${auditionResponse.title}",
                          ),
                          Spaces.h4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.person),
                              Flexible(
                                child: PrimaryText(
                                  text: "${auditionResponse.title} ",
                                  fontStyle: FontStyle.italic,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spaces.h8,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: TitleText(
                          title: "Posted",
                          text: "${auditionResponse.created_at?.split(" ")[0]}",
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TitleText(
                          title: "Expiry",
                          text: "${auditionResponse.validity?.split(" ")[0]}",
                        ),
                      ),
                    ],
                  ),
                ),
                Spaces.h8,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TitleText(
                          title: "Location",
                          text: "${auditionResponse.location}",
                        ),
                      ),
                      RoundedButton(
                        text: "${appliedAuditionModel.status}",
                        textColor: AppColors.black,
                        topPadding: 8.0,
                        leftPadding: 32.0,
                        rightPadding: 32.0,
                        bottomPadding: 8.0,
                        onPressed: () {},
                      )
                    ],
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
