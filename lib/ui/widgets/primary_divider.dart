import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';

class PrimaryDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;

  const PrimaryDivider({
    Key key,
    this.color = AppColors.pink,
    this.height = 2.0,
    this.leftPadding = 24.0,
    this.rightPadding = 24.0,
    this.bottomPadding = 16.0,
    this.topPadding = 16.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        leftPadding,
        topPadding,
        rightPadding,
        bottomPadding,
      ),
      child: Divider(
        color: this.color,
        height: this.height,
      ),
    );
  }
}
