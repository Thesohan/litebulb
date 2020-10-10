import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';

typedef OnRetry = void Function();

class PrimaryErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final OnRetry onRetry;
  final IconData iconData;
  const PrimaryErrorWidget({
    Key key,
    @required this.message,
    this.title = "OOPS!",
    this.onRetry,
    this.iconData,
  })  : assert(title != null && message != null && iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _errorIcon,
            Spaces.h20,
            _title,
            Spaces.h20,
            _description,
            Spaces.h30,
            _retryButton,
          ],
        ),
      ),
    );
  }

  Widget get _title {
    return Text(
      this.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget get _errorIcon {
    return Icon(
      Icons.warning,
      size: 80.0,
    );
  }

  Widget get _description {
    return Text(
      this.message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  Widget get _retryButton {
    return RawMaterialButton(
      fillColor: AppColors.red,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppConstants.BOX_CORNER_BUTTON_RADIUS),
      ),
      elevation: 0.0,
      highlightElevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      onPressed: this.onRetry,
      child: Text(
        'Retry',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
