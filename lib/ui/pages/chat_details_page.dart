import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'dart:math' as math;

class ChatDetailsPage extends StatelessWidget {
  final String data;

  const ChatDetailsPage({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildChatDetails(context,data),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.black,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.DANCE),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Spaces.w32,
          Expanded(
            child: PrimaryText(
              text: "Lorem Ipsum Name",
              fontSize: AppConstants.HEADING,
              fontWeight: FontWeight.bold,
              maxLines: 1,
            ),
          )
        ],
      ),
      backgroundColor: AppColors.white,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildChatDetails(BuildContext context, String data) {
    return Column(
      children: <Widget>[
//        Expanded(
//          child: ListView.builder(
//            primary: true,
//            shrinkWrap: true,
//            reverse: true,
//            itemCount: 20,
//            itemBuilder: (context, index) {
//              return _BuildMessageItem(index: index);
//            },
//          ),
//        ),
      PrimaryText(text: 'data_>$data',),
        Spaces.h8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: AppConstants.CARD_ELEVATION,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48.0),
            ),
            child: Center(
              child: TextField(
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Icon(
                      Icons.attachment,
                      size: 32.0,
                      color: AppColors.pink,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.send,
                    size: 32.0,
                    color: AppColors.pink,
                  ),
                ),
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildMessageItem extends StatelessWidget {
  final int index;

  const _BuildMessageItem({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: index % 2 == 0 ? WrapAlignment.end : WrapAlignment.start,
        children: <Widget>[
          Container(
            width: 296.0,
            child: Center(
              child: Card(
                color: index % 2 == 0
                    ? AppColors.unseenNotification
                    : AppColors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Spaces.h24,
                      index % 2 == 0
                          ? Image.asset(
                              ImageAssets.DANCE,
                              height: 120.0,
                              width: 240.0,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                      index % 2 == 0 ? Spaces.h24 : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrimaryText(
                          text:
                              "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryText(
                            text: "18:27",
                            color: AppColors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
