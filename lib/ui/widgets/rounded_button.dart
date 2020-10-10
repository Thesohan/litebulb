import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/util/size_config.dart';

typedef OnPressed = void Function();

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.text,
    this.onPressed,
    this.buttonColor = AppColors.lightPink,
    this.fontFamily = 'Montserrat.Regular',
    this.fontSize = AppConstants.NORMAL,
    this.circularRadius = 24.0,
    this.textColor = AppColors.pink,
    this.leftPadding = 2.0,
    this.bottomPadding = 2.0,
    this.rightPadding = 2.0,
    this.topPadding = 2.0,
  });

  final double fontSize;
  final String fontFamily;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final OnPressed onPressed;
  final double circularRadius;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Card(
        color: this.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.circularRadius),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            this.leftPadding,
            this.topPadding,
            this.rightPadding,
            this.bottomPadding,
          ),
          child: Text(
            this.text,
            style: TextStyle(
              color: this.textColor,
              fontSize: SizeConfig.safeBlockHorizontal * this.fontSize,
              fontFamily: this.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
