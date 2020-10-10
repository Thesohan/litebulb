 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';

class BuildChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryText(
                  text: "Chats",
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
                  return _ChatScreenItemBuilder();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatScreenItemBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 24,
        child: InkWell(
          onTap: () {
            Routes.navigate(Routes.CHAT_DETAILS_PAGE);
          },
          child: Card(
            elevation: AppConstants.CARD_ELEVATION,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.safeBlockVertical * 12),
                      child: Image.asset(
                        ImageAssets.DANCE,
                        width: SizeConfig.safeBlockVertical * 12,
                        height: SizeConfig.safeBlockVertical * 12,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: PrimaryText(
                                text: "Lorem Ipsum Name",
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.NORMAL,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: SizeConfig.safeBlockVertical * 4,
                                height: SizeConfig.safeBlockVertical * 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightPink,
                                ),
                                child: Center(
                                  child: PrimaryText(
                                    text: " 23",
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: PrimaryText(
                            maxLines: 1,
                            text: "xyz audition for abc",
                            color: AppColors.gray,
                            fontSize: AppConstants.SMALL,
                          ),
                        ),
                        Flexible(
                          child: PrimaryText(
                            maxLines: 1,
                            text:
                                "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: PrimaryText(
                              text: "17:20",
                              color: AppColors.pink,
                              maxLines: 1,
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
      ),
    );
  }
}
