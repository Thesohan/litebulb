import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/data/models/sponser_model.dart';
import 'package:new_artist_project/util/size_config.dart';

class BuildSponserList extends StatelessWidget {
  const BuildSponserList({
    Key key,
    @required this.sponserList,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final List<Sponser> sponserList;
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 20,
      child: ListView.builder(
        scrollDirection: this.scrollDirection,
        shrinkWrap: true,
        itemCount: sponserList.length,
        itemBuilder: (context, index) {
          return _BuildSponserItem(sponser: sponserList[index]);
        },
      ),
    );
  }
}

class _BuildSponserItem extends StatelessWidget {
  const _BuildSponserItem({
    Key key,
    this.sponser,
  }) : super(key: key);

  final Sponser sponser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Image.asset(
            ImageAssets.SPONSER,
            width: SizeConfig.safeBlockVertical * 16,
            height: SizeConfig.safeBlockVertical * 16,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
