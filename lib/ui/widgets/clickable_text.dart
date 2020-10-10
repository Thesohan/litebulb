import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';

typedef OnPressed = void Function();

class ClickableText extends StatelessWidget {
  final String text;
  final OnPressed onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const ClickableText({
    @required this.text,
    @required this.onPressed,
    this.fontWeight = FontWeight.normal,
    this.fontSize = AppConstants.NORMAL,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        child: Column(
          children: <Widget>[
            PrimaryText(
                text: this.text,
                color: AppColors.primary,
                fontSize: this.fontSize,
                fontWeight: this.fontWeight),
          ],
        ),
      ),
    );
  }
}
