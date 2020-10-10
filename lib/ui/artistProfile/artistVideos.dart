import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc.dart';
import 'package:new_artist_project/blocs/artistProfileBloc/artist_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/upload_video_bloc/video_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/artist_video_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_all_video_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class Videos extends StatelessWidget {
  final ArtistProfileBloc artistProfileBloc;
  final bool isLoggedIn;
  final ArtistProfileResponse artistProfileResponse;

  const Videos(
      {Key key,
      @required this.artistProfileBloc,
      this.isLoggedIn: false,
      this.artistProfileResponse})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    _fetchData();
    return StreamBuilder<Resource<ArtistProfileResponse>>(
        stream: artistProfileBloc.artistBioResponseObservable,
        builder: (context, snapshot) {
          if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data.isSuccess) {
            Resource<ArtistProfileResponse> res = snapshot.data;
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: StreamBuilder<Resource<ArtistAllVideoResponse>>(
                    stream: artistProfileBloc.artistVideosObservable,
                    builder: (context, snapshot) {
                      if (snapshot != null &&
                          snapshot.data != null &&
                          snapshot.data.isSuccess) {
                        List<ArtistVideoResponse> artistVideos =
                            snapshot.data.data.data;
                        return ListView.builder(
                          primary: false,
                          itemCount: artistVideos.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _BuildVideoItem(
                              artistVideoResponse: artistVideos[index],
                              artistVideos: artistVideos,
                              isLoggedIn: this.isLoggedIn,
                              artistProfileResponse:
                                  artistProfileResponse ?? res.data,
                            );
                          },
                        );
                      } else {
                        return SpinKitFadingCircle(
                          color: AppColors.red,
                        );
                      }
                    }),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: AppColors.red,
            );
          }
        });
  }

  void _fetchData() {
    this.isLoggedIn == true && artistProfileResponse == null
        ? artistProfileBloc.dispatch(
            FetchArtistVideoEvent(),
          )
        : artistProfileBloc.dispatch(
            FetchArtistVideoEvent(artistId: artistProfileResponse.id),
          );
    artistProfileBloc.getLoggedInArtistProfile();
  }
}

class _BuildVideoItem extends StatelessWidget {
  final ArtistVideoResponse artistVideoResponse;
  final List<ArtistVideoResponse> artistVideos;
  final ArtistProfileResponse artistProfileResponse;
  final bool isLoggedIn;
  const _BuildVideoItem(
      {Key key,
      @required this.artistVideoResponse,
      @required this.artistVideos,
      @required this.artistProfileResponse,
      this.isLoggedIn = false})
      : super(key: key);

  void _fetchData(BuildContext context) {
    ArtistProfileBloc artistProfileBloc =
        Provider.of<ArtistProfileBloc>(context);
    this.isLoggedIn == true && artistProfileResponse == null
        ? artistProfileBloc.dispatch(
            FetchArtistVideoEvent(),
          )
        : artistProfileBloc.dispatch(
            FetchArtistVideoEvent(artistId: artistProfileResponse.id),
          );
    artistProfileBloc.getLoggedInArtistProfile();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        artistVideos.remove(artistVideoResponse);
        Routes.navigate(Routes.WATCHING_VIDEO_PAGE, params: {
          ParameterKey.VIDEO_RESPONSE: artistVideoResponse,
          ParameterKey.VIDEO_RESPONSE_LIST: artistVideos,
          ParameterKey.OTHER_ARTIST_PROFILE: artistProfileResponse,
          ParameterKey.IS_LOGGED_IN:isLoggedIn
        }).whenComplete(() {
          _fetchData(context);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Container(
          height: SizeConfig.safeBlockVertical * 14,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: artistVideoResponse.thumbnail_url != null
                    ? Image.network(
                        "${artistVideoResponse.thumbnail_url}",
                        width: SizeConfig.safeBlockVertical * 12,
                        height: SizeConfig.safeBlockVertical * 12,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImageAssets.DANCE,
                        width: SizeConfig.safeBlockVertical * 12,
                        height: SizeConfig.safeBlockVertical * 12,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: PrimaryText(
                          maxLines: 1,
                          text: "${artistVideoResponse.title}",
                          fontSize: AppConstants.SUB_HEADING,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spaces.h8,
                      Flexible(
                        child: PrimaryText(
                          maxLines: 3,
                          color: AppColors.grayText,
                          fontSize: AppConstants.SMALL,
                          text: "${artistVideoResponse.description}",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
