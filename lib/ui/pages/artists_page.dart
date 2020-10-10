import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/ui/artists/build_artist_list.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({
    Key key,
    this.categorisedArtistList,
    this.isLoggedIn = false,
  })  : assert(categorisedArtistList != null),
        super(key: key);
  final bool isLoggedIn;
  final Map<String, List<ArtistProfileResponse>> categorisedArtistList;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBarView = [];
    for (int i = 0; i < categorisedArtistList.length; i++) {
      String cat = categorisedArtistList.keys.toList()[i];
      tabBarView.add(
        BuildArtistList(
          artistList: categorisedArtistList[cat],
          category: cat,
          isLoggedIn: isLoggedIn,
        ),
      );
    }
    return DefaultTabController(
      length: categorisedArtistList.length,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                Icons.search,
//              ),
//              onPressed: () {},
//            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: List<Widget>.generate(
              categorisedArtistList.length,
              (index) => Tab(
                text: categorisedArtistList.keys.toList()[index],
              ),
            ),
          ),
          title: PrimaryText(
            text: 'Artist',
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppConstants.SUB_HEADING,
          ),
        ),
        body: TabBarView(
          children: tabBarView,
        ),
      ),
    );
  }
}
