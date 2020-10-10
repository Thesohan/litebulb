import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/audition_model.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

typedef OnTap = void Function(AuditionResponse auditionModel);

class BuildFeaturedAuditionList extends StatelessWidget {
  const BuildFeaturedAuditionList({
    Key key,
    @required this.auditionList,
    this.scrollDirection = Axis.vertical,
    this.onTap,
  }) : super(key: key);

  final OnTap onTap;
  final List<AuditionResponse> auditionList;
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
            24.0,
            24.0,
            24.0,
            16.0,
          ),
          child: PrimaryText(
            text: "Featured Audition",
            fontSize: AppConstants.HEADING,
            fontWeight: FontWeight.bold,
          ),
        ),
        CarouselSlider(
          height: SizeConfig.safeBlockVertical * 56,
          initialPage: 0,
          viewportFraction: .8,
          enlargeCenterPage: true,
          autoPlay: false,
          enableInfiniteScroll: true,
          onPageChanged: (index) {},
          items: auditionList.map(
            (audition) {
              return Builder(
                builder: (BuildContext context) {
                  return _BuildFeaturedAuditionItem(
                    audition: audition,
                    onTap: this.onTap,
                  );
                },
              );
            },
          ).toList(),
        )
      ],
    );
  }
}

class _BuildFeaturedAuditionItem extends StatelessWidget {
  const _BuildFeaturedAuditionItem({
    Key key,
    this.audition,
    this.onTap,
  }) : super(key: key);

  final AuditionResponse audition;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    AuditionBloc _auditionBloc = Provider.of<AuditionBloc>(context);
    _auditionBloc.dispatch(
      FetchCategoryEvent(
        id: audition.category_id,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(audition),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: audition.image_url != null
                  ? Image.network(
                      "https://${audition.image_url.split(',').toList()[0]}",
                      height: SizeConfig.safeBlockVertical * 28,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      ImageAssets.DANCE,
                      height: SizeConfig.safeBlockVertical * 28,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: PrimaryText(
                            fontWeight: FontWeight.bold,
                            text: "${audition.title}",
                            maxLines: 1,
                            fontSize: AppConstants.NORMAL,
                          ),
                        ),
                        Flexible(
                          child: PrimaryText(
                              fontSize: AppConstants.NORMAL,
                              maxLines: 2,
                              text: '${audition.title}'),
                        ),
                        Flexible(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person),
                              Spaces.w8,
                              Expanded(
                                child: PrimaryText(
                                  maxLines: 1,
                                  fontSize: AppConstants.NORMAL,
                                  fontStyle: FontStyle.italic,
                                  text: "${audition.title}",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              RoundedButton(
                                text: '${audition.validity?.split(" ")[0]}',
                              ),
                              Spaces.w4,
                              StreamBuilder<String>(
                                  stream:
                                      _auditionBloc.categoryBehaviourObservable,
                                  builder: (context, snapshot) {
                                    if (snapshot != null &&
                                        snapshot.data != null) {
                                      return RoundedButton(
                                        text: "${snapshot.data}",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
