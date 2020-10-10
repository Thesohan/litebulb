import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/primary_text_form_field.dart';

typedef OnPressed = void Function();
typedef OnCancelTapped = void Function();

/// Primary Dialog used to used throughout the application.
///
/// Returns a [bool] response depending on user selection.
/// true for 'ok' action, false for 'cancel' action.
class ReportDialog extends StatelessWidget {
  final OnPressed onPressed;

  const ReportDialog({
    Key key,
    @required this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

  /// Helper method that displays the dialog automatically
  /// using `showDialog`.
  static Future<bool> show(
    BuildContext context, {
    OnPressed onOkTapped,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return ReportDialog(
          onPressed: onOkTapped,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.BOX_CORNER_BUTTON_RADIUS),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: PrimaryText(
                text: "REPORT",
              ),
            ),
            Spaces.h32,
            PrimaryTextFormField(
              title: "Reason For Reporting The Audition?",
              hintText: " +Add",
            ),
            Spaces.h32,
            PrimaryTextFormField(
              title: "Any Suggestion?",
              hintText: " +Add",
            ),
            Spaces.h64,
            PrimaryButton(
              text: "Submit",
              onPressed: this.onPressed,
            )
          ],
        ),
      ),
    );
  }
}
