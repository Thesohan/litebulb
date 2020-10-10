import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc.dart';
import 'package:new_artist_project/blocs/all_artist_bloc/all_artist_bloc_event.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class BuildArtistList extends StatelessWidget {
  const BuildArtistList({
    Key key,
    @required this.artistList,
    this.category,
    this.isLoggedIn = false,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final List<ArtistProfileResponse> artistList;
  final Axis scrollDirection;
  final String category;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      scrollDirection: this.scrollDirection,
      shrinkWrap: true,
      itemCount: artistList.length,
      itemBuilder: (context, index) {
        return _BuildArtistItem(
          artist: artistList[index],
          category: category,
          isLoggedIn: isLoggedIn,
        );
      },
      separatorBuilder: (context, index) {
        return Spaces.h8;
      },
    );
  }
}

class _BuildArtistItem extends StatelessWidget {
  const _BuildArtistItem(
      {Key key, this.artist, this.category, this.isLoggedIn = false,this.allArtistBloc,})
      : super(key: key);

  final AllArtistBloc allArtistBloc;
  final bool isLoggedIn;
  final ArtistProfileResponse artist;
  final String category;

  @override
  Widget build(BuildContext context) {
    AllArtistBloc allArtistBloc = Provider.of<AllArtistBloc>(context);
    return InkWell(
      onTap: () {
        Routes.navigate(Routes.ARTIST_PROFILE_PAGE, params: {
          ParameterKey.OTHER_ARTIST_PROFILE: artist,
          ParameterKey.OTHER_ARTIST_PROFILE_CATEGORY: category,
          ParameterKey.IS_LOGGED_IN: isLoggedIn,
        }).then((value){
          if(Navigator.canPop(context)){
            Navigator.pop(context);
          }
          allArtistBloc.dispatch(FetchAllArtistEvent());
        });
      },
      child: Container(
        height: SizeConfig.safeBlockVertical * 16,
        child: Card(
          elevation: AppConstants.CARD_ELEVATION,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.safeBlockVertical * 10),
                  child: artist.avatar_loc != null
                      ? Image.network(
                          "https://${artist.avatar_loc}",
                          width: SizeConfig.safeBlockVertical * 10,
                          height: SizeConfig.safeBlockVertical * 10,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          ImageAssets.DANCE,
                          width: SizeConfig.safeBlockVertical * 10,
                          height: SizeConfig.safeBlockVertical * 10,
                          fit: BoxFit.cover,
                        ),
                ),
                Spaces.w16,
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PrimaryText(
                        text: artist.name ?? "",
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.NORMAL,
                        maxLines: 1,
                      ),
                      Spaces.h4,
                      PrimaryText(
                          maxLines: 2,
                          fontSize: AppConstants.NORMAL,
                          text: artist.local ?? ""),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PrimaryText(
                        text: "${artist.age} y/s",
                        maxLines: 1,
                      ),
                      PrimaryText(
                        maxLines: 1,
                        text: "${this.category}",
                        fontStyle: FontStyle.italic,
                        fontFamily: AppConstants.MONTSERRAT,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
