import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';

class AuditionTrackingPage extends StatefulWidget {
  @override
  _AuditionTrackingState createState() {
    return _AuditionTrackingState();
  }
}

class _AuditionTrackingState extends State<AuditionTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24.0),
          primary: true,
          children: <Widget>[
            PrimaryText(
              text: "Audition Tracking",
              fontSize: AppConstants.HEADING,
              fontWeight: FontWeight.bold,
            ),
            Spaces.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TitleText(
                  title: "Posted",
                  text: "July 17,2019",
                ),
                TitleText(
                  title: "Expiry",
                  text: "Aug 17,2019",
                ),
              ],
            ),
            Spaces.h64,
            buildAuditionTimeLine(),
          ],
        ),
      ),
    );
  }

  Widget buildAuditionTimeLine() {
    return Card(
      elevation: AppConstants.CARD_ELEVATION,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            timelineRow(
              title: "Applied",
              hasNext: true,
              isActive: true,
            ),
            timelineRow(
              title: "Call Accepted",
              hasNext: true,
              isActive: true,
            ),
            timelineRow(
              title: "Profile Checked",
              hasNext: true,
              isActive: true,
            ),
            timelineRow(
              title: "Offer",
              hasNext: true,
              isActive: true,
            ),
            timelineRow(
              title: "Rejected/Selected",
              hasNext: false,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget timelineRow({
    String title,
    bool hasNext,
    bool isActive,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PrimaryText(
          text: title,
          color: isActive ? AppColors.pink : AppColors.gray,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: isActive ? AppColors.pink : AppColors.gray,
            ),
            hasNext
                ? Container(
                    width: 2,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: isActive ? AppColors.pink : AppColors.gray,
                      shape: BoxShape.rectangle,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
