import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/util/size_config.dart';

class PrimaryText extends StatelessWidget {
  PrimaryText({
    @required this.text,
    this.fontSize = AppConstants.NORMAL,
    this.fontFamily = AppConstants.MONTSERRAT,
    this.fontWeight,
    this.maxLines,
    this.fontStyle = FontStyle.normal,
    this.color = AppColors.black,
  });

  final FontWeight fontWeight;
  final String text;
  final double fontSize;
  final String fontFamily;
  final int maxLines;
  final Color color;
  final FontStyle fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      maxLines: this.maxLines,
      style: TextStyle(
        fontStyle: this.fontStyle,
        fontSize: SizeConfig.safeBlockHorizontal * this.fontSize,
        fontFamily: this.fontFamily,
        fontWeight: this.fontWeight,
        color: this.color,
      ),
    );
  }
}
