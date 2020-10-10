import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';

class NotificationPage extends StatelessWidget {
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryText(
                    text: "Notifications",
                    fontSize: AppConstants.HEADING,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spaces.h8,
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return _NotificationItemBuilder(index: index);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationItemBuilder extends StatelessWidget {
  final int index;

  const _NotificationItemBuilder({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 20,
        child: Card(
          color:
              index % 2 == 0 ? AppColors.unseenNotification : AppColors.white,
          elevation: AppConstants.CARD_ELEVATION,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    SizeConfig.safeBlockVertical * 10,
                  ),
                  child: Image.asset(
                    ImageAssets.DANCE,
                    width: SizeConfig.safeBlockVertical * 10,
                    height: SizeConfig.safeBlockVertical * 10,
                    fit: BoxFit.cover,
                  ),
                ),
                Spaces.w32,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: PrimaryText(
                          text: "Lorem Ipsum Name",
                          maxLines: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: PrimaryText(
                          text:
                              "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryText(
                            text: "17:21",
                            maxLines: 1,
                            color: AppColors.pink,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
