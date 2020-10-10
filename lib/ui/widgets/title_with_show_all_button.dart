import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';
import 'package:new_artist_project/util/size_config.dart';

typedef OnPressed = void Function();

class TitleWithShowAllButton extends StatelessWidget {
  const TitleWithShowAllButton({
    @required this.title,
    this.buttonText,
    this.onPressed,
  });

  final String title;
  final String buttonText;
  final OnPressed onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: PrimaryText(
            text: this.title,
            fontSize: AppConstants.HEADING,
            fontWeight: FontWeight.bold,
            fontFamily: AppConstants.MONTSERRAT,
          ),
        ),
        Flexible(
          flex: 1,
          child: this.buttonText != null
              ? RoundedButton(
                  onPressed: this.onPressed,
                  text: this.buttonText,
                  fontSize: AppConstants.NORMAL,
                )
              : Container(),
        ),
      ],
    );
  }
}
