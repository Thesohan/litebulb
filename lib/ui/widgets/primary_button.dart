import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

typedef OnPressed = Function();
enum BUTTON_SIZE { small, medium, large }

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    this.text,
    this.onPressed,
    this.color = AppColors.pink,
    this.borderRadius = 4.0,
    this.size = BUTTON_SIZE.medium,
    this.textColor = AppColors.white,
  });

  final BUTTON_SIZE size;
  final String text;
  final Color color;
  final OnPressed onPressed;
  final double borderRadius;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (this.size == BUTTON_SIZE.small) {
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius),
        ),
        color: this.color,
        onPressed: this.onPressed,
        child: PrimaryText(
          text: this.text,
          fontSize: AppConstants.SMALL,
          color: this.textColor,
        ),
      );
    } else if (this.size == BUTTON_SIZE.medium) {
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius),
        ),
        color: this.color,
        onPressed: this.onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: PrimaryText(
            text: this.text,
            fontSize: AppConstants.NORMAL,
            color: this.textColor,
          ),
        ),
      );
    }
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.borderRadius),
      ),
      color: this.color,
      onPressed: this.onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: PrimaryText(
          text: this.text,
          fontSize: AppConstants.SUB_HEADING,
          color: this.textColor,
        ),
      ),
    );
  }
}
