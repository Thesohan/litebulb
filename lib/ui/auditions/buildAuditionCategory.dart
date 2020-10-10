import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class BuildAuditionList extends StatelessWidget {
  const BuildAuditionList({
    Key key,
    this.scrollDirection = Axis.vertical,
    @required this.auditionResponseList,
    this.isAddedInWishList = false,
  })  : assert(auditionResponseList != null),
        super(key: key);

  final bool isAddedInWishList;
  final List<AuditionResponse> auditionResponseList;
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      scrollDirection: this.scrollDirection,
      itemBuilder: (context, index) {
        return _BuildAuditionItem(
            audition: auditionResponseList[index],
            isAddedInWishlist: isAddedInWishList);
      },
      separatorBuilder: (context, index) {
        return PrimaryDivider(
          rightPadding: 32.0,
          leftPadding: 32.0,
        );
      },
      itemCount: auditionResponseList.length,
    );
  }
}

class _BuildAuditionItem extends StatelessWidget {
  const _BuildAuditionItem({
    Key key,
    @required this.audition,
    this.isAddedInWishlist = false,
  }) :assert(audition!=null), super(key: key);

  final AuditionResponse audition;
  final bool isAddedInWishlist;

  @override
  Widget build(BuildContext context) {
    AuditionBloc auditionBloc = Provider.of<AuditionBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      child: InkWell(
        onTap: () {
          Routes.navigate(Routes.AUDITION_DETAIL_PAGE, params: {
            ParameterKey.AUDITION: audition,
          }).whenComplete(() {
            auditionBloc.dispatch(FetchWishlistEvent());
          });
        },
        child: Card(
          elevation: AppConstants.CARD_ELEVATION,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.safeBlockVertical * 10,
                  height: SizeConfig.safeBlockVertical * 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: audition.image_url == null
                          ? AssetImage(ImageAssets.DANCE)
                          : NetworkImage(
                              'https://${audition.image_url.split(',').toList()[0]}'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Spaces.w24,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PrimaryText(
                          text: "${audition.title}",
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                        ),
                        Spaces.h8,
                        RoundedButton(
                          text: "${audition.validity?.split(' ')[0]}",
                          textColor: AppColors.primary,
                          fontFamily: 'Montserrat.medium',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
