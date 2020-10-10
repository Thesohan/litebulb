import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/ui/widgets/rounded_button.dart';

/// this widget must be called from inside of a list or column or row.
class WrappedList extends StatelessWidget {
  const WrappedList({
    Key key,
    this.items,
    this.backgroundColor = AppColors.red,
    this.textColor = AppColors.white,
  }) : super(key: key);
  final List<String> items;
  final backgroundColor;
  final textColor;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.generate(
      items.length,
      (index) {
        return RoundedButton(
          buttonColor: this.backgroundColor,
          text: items[index],
          leftPadding: 16.0,
          rightPadding: 16.0,
          topPadding: 8.0,
          bottomPadding: 8.0,
          textColor: this.textColor,
        );
      },
    );

    return Wrap(children: widgets);
  }
}
