import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key key, this.title, this.text}) : super(key: key);

  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PrimaryText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: AppConstants.SUB_HEADING,
          color: AppColors.pink,
        ),
        Spaces.h8,
        PrimaryText(
          text: text,
          fontSize: AppConstants.NORMAL,
        ),
      ],
    );
  }
}
