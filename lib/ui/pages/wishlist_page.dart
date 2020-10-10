import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/ui/auditions/buildAuditionCategory.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuditionBloc auditionBloc = Provider.of<AuditionBloc>(context);
    auditionBloc.dispatch(FetchWishlistEvent());
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: "Wishlist",
          fontSize: AppConstants.HEADING,
        ),
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: StreamBuilder<Resource<List<AuditionResponse>>>(
            stream: auditionBloc.artistWishlistResponseObservable,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.isSuccess) {
                return BuildAuditionList(
                  auditionResponseList: snapshot.data.data,
                  isAddedInWishList: true,
                );
              }
              return SpinKitFadingCircle(
                color: AppColors.red,
              );
            }),
      ),
    );
  }
}
