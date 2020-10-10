import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

typedef OnOkTapped = void Function();
typedef OnCancelTapped = void Function();

/// Primary Dialog used to used throughout the application.
///
/// Returns a [bool] response depending on user selection.
/// true for 'ok' action, false for 'cancel' action.
class PrimaryConfirmationDialog extends StatelessWidget {
  final String _okText;
  final String _cancelText;
  final String message;
  final OnOkTapped onOkTapped;
  final bool okButtonNavigationHandled;
  final OnCancelTapped onCancelTapped;
  final bool showCancelButton;

  const PrimaryConfirmationDialog({
    Key key,
    this.okButtonNavigationHandled = false,
    this.onOkTapped,
    this.onCancelTapped,
    String okText,
    String cancelText,
    @required this.message,
    this.showCancelButton = true,
  })  : _okText = okText ?? "OK",
        _cancelText = cancelText ?? "Cancel",
        assert(message != null),
        assert(showCancelButton != null),
        super(key: key);

  /// Helper method that displays the dialog automatically
  /// using `showDialog`.
  static Future<bool> show(
    BuildContext context, {
    String okText,
    bool okButtonNavigationHandled,
    String cancelText,
    @required String message,
    OnOkTapped onOkTapped,
    OnCancelTapped onCancelTapped,
    bool showCancelButton,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return PrimaryConfirmationDialog(
          message: message,
          onOkTapped: onOkTapped,
          onCancelTapped: onCancelTapped,
          cancelText: cancelText,
          okButtonNavigationHandled: okButtonNavigationHandled,
          okText: okText,
          showCancelButton: showCancelButton ?? true,
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Text(
                this.message.toUpperCase(),
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Spaces.h32,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                this.showCancelButton
                    ? Expanded(child: _buildCancelButton(context))
                    : Container(),
                this.showCancelButton ? Spaces.w14 : Container(),
                Expanded(child: _buildOkButton(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(AppConstants.BOX_CORNER_BUTTON_RADIUS),
      child: RawMaterialButton(
        fillColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppConstants.BOX_CORNER_BUTTON_RADIUS),
          side: BorderSide(
            color: Colors.pinkAccent,
          ),
        ),
        onPressed: () {
          if (this.onCancelTapped != null) {
            this.onCancelTapped();
          }
          Navigator.of(context).pop(false);
        },
        child: PrimaryText(
          text: this._cancelText.toUpperCase(),
          color: AppColors.pink,
        ),
      ),
    );
  }

  Widget _buildOkButton(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(AppConstants.BOX_CORNER_BUTTON_RADIUS),
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0.0,
        onPressed: () {
          if (this.onOkTapped != null) {
            this.onOkTapped();
          }
          if (!okButtonNavigationHandled) {
            Navigator.of(context).pop(true);
          }
        },
        child: PrimaryText(
          text: this._okText.toUpperCase(),
          color: AppColors.white,
        ),
        fillColor: AppColors.red,
      ),
    );
  }
}
