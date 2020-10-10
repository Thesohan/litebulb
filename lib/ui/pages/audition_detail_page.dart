import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/api/request/add_to_wishlist_request.dart';
import 'package:new_artist_project/data/models/api/request/apply_audition_request.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/clickable_text.dart';
import 'package:new_artist_project/ui/widgets/dialogs/primary_confirmation_dialog.dart';
import 'package:new_artist_project/ui/widgets/dialogs/report_dialog.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_slider.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/wrapped_list.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class AuditionDetailPage extends StatefulWidget {
  final AuditionResponse auditionResponse;
  const AuditionDetailPage({
    Key key,
    this.auditionResponse,
  }) : super(key: key);
  @override
  _AuditionDetailPageState createState() {
    return _AuditionDetailPageState();
  }
}

class _AuditionDetailPageState extends State<AuditionDetailPage> {
  bool isAlreadyApplied;
  bool isAddedInWishlist;

  AuditionBloc _auditionBloc;
  @override
  void didChangeDependencies() {
    _auditionBloc = Provider.of<AuditionBloc>(context);
    _auditionBloc.dispatch(
      FetchCategoryEvent(id: widget.auditionResponse.category_id),
    );
    _auditionBloc.dispatch(
      FetchSubCategoryEvent(id: widget.auditionResponse.subcategory_id),
    );

    _auditionBloc.dispatch(
      GetRolesEvent(id: widget.auditionResponse.role_id),
    );

    super.didChangeDependencies();
  }

  @override
  void initState() {
    isAlreadyApplied = widget.auditionResponse.is_applied=='1';
    isAddedInWishlist = widget.auditionResponse.is_addedtowishlist=='1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              value == "share"
                  ? print("share")
                  : ReportDialog.show(
                      context,
                      onOkTapped: () {},
                    );
            },
            itemBuilder: (context) {
              return List<PopupMenuEntry>.generate(
                2,
                (index) {
                  if (index == 0) {
                    return PopupMenuItem(
                      value: "share",
                      child: Text("share"),
                    );
                  } else {
                    return PopupMenuItem(
                      value: "Report",
                      child: Text("Report"),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: _buildBody(context, _auditionBloc),
    );
  }

  Widget _buildBody(BuildContext context, AuditionBloc auditionBloc) {
    return SafeArea(
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: <Widget>[
          PrimarySlider(
            images: _getImageUrl(widget.auditionResponse.image_url),
          ),
          Spaces.h32,
          _buildAboutCard(),
          Spaces.h8,
          _buildCategoryAndDate(auditionBloc),
          Spaces.h8,
          _buildAddress(),
          Spaces.h8,
          _buildTwoTexts(
              "${(widget.auditionResponse.gender == "0" || widget.auditionResponse.gender == 'Male') ? 'Male' : 'Female'}",
              "${widget.auditionResponse.age_group} y/o",
              MainAxisAlignment.spaceEvenly),
          Spaces.h8,
          _buildRestField(),
          Spaces.h8,
          _auditionCallValidity(),
          Spaces.h8,
          StreamBuilder<String>(
              stream: auditionBloc.roleNameBehaviourObservable,
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.data != null) {
                  return _buildTwoTexts(
                    "Roll Type",
                    "${snapshot.data}",
                    MainAxisAlignment.spaceBetween,
                  );
                } else {
                  return Container();
                }
              }),
          Spaces.h8,
          _buildTwoTexts(
            "Budget",
            "${widget.auditionResponse.budget}",
            MainAxisAlignment.spaceBetween,
          ),
          Spaces.h8,
          StreamBuilder<String>(
              stream: auditionBloc.subCategoryBehaviourObservable,
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.data != null) {
                  return _buildTwoTexts(
                    "Audition Type",
                    "${snapshot.data}",
                    MainAxisAlignment.spaceBetween,
                  );
                } else {
                  return Container();
                }
              }),
          Spaces.h8,
          _buildAuditionType("${widget.auditionResponse.is_paid}"),
          Spaces.h32,
          isAlreadyApplied
              ? _buildAppliedButton()
              : _applyOrWishList(context, auditionBloc),
          Spaces.h40,
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spaces.h16,
              PrimaryText(
                text: "${widget.auditionResponse.title}",
                fontSize: AppConstants.HEADING,
              ),
              Spaces.h8,
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        Spaces.w8,
                        Flexible(
                          child: ClickableText(onPressed: (){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return SpinKitFadingCircle(
                                  color: AppColors.red,
                                );
                              },
                            );
                            _auditionBloc.dispatch(
                              FetchAuditionAgencyDetailsEvent(
                                username: widget.auditionResponse.agency_name,completer: _profileResponseCompleter()
                              ),
                            );

                          },
                            text: "${widget.auditionResponse.agency_name}",
                            fontSize: AppConstants.SUB_HEADING,
                          ),
                        ),
                      ],
                    );
                  }),
              Spaces.h16,
              Html(data: widget.auditionResponse.content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryAndDate(AuditionBloc auditionBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: StreamBuilder<String>(
                      stream: auditionBloc.categoryBehaviourObservable,
                      builder: (context, snapshot) {
                        if (snapshot != null && snapshot.data != null) {
                          return PrimaryText(
                            text: "${snapshot.data}",
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ),
          ),
          Spaces.w8,
          Expanded(
            child: Card(
              elevation: AppConstants.CARD_ELEVATION,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: PrimaryText(
                    text:
                        "${widget.auditionResponse.created_at?.split(" ")[0]}",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 48.0,
              ),
              Spaces.w8,
              Flexible(
                child: PrimaryText(
                  text: "${widget.auditionResponse.location}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTwoTexts(
      String text1, String text2, MainAxisAlignment mainAxisAlignment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: <Widget>[
              PrimaryText(
                text: text1,
              ),
              Spaces.w8,
              PrimaryText(
                text: text2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuditionType(String isPaid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: PrimaryText(
              text: isPaid == "1" ? 'Paid' : 'Unpaid',
            ),
          ),
        ),
      ),
    );
  }

  Widget _applyOrWishList(BuildContext context, AuditionBloc auditionBloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: PrimaryButton(
              text: 'Apply Now',
              onPressed: () {
                PrimaryConfirmationDialog.show(
                  context,
                  okButtonNavigationHandled: true,
                  showCancelButton: true,
                  message: 'Do you want to apply for this audition?',
                  onCancelTapped: () {},
                  onOkTapped: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SpinKitFadingCircle(
                          color: AppColors.red,
                        );
                      },
                    );
                    auditionBloc.dispatch(
                      ApplyAuditionEvent(
                        appliedAuditionRequest: ApplyAuditionRequest(
                          agencyid: widget.auditionResponse.user_id,
                          postid: widget.auditionResponse.id,
                          status: 'Applied',
                        ),
                        completer: Completer()
                          ..future.then(
                            (msg) {
                              if (msg == 'Applied') {
                                Navigator.of(context).pop();
                                setState(() {
                                  isAlreadyApplied = true;
                                });
                              }
                            },
                          ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Flexible(
            child: PrimaryButton(
              text: isAddedInWishlist
                  ? "Removed from wishlist"
                  : "Add To Wishlist",
              onPressed: () {
                PrimaryConfirmationDialog.show(
                  context,
                  okButtonNavigationHandled: true,
                  showCancelButton: true,
                  message: isAddedInWishlist
                      ? 'Do you want to remove this audition from wishlist'
                      : 'Do you want to add this audition in your wishlist?',
                  onCancelTapped: () {},
                  onOkTapped: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SpinKitFadingCircle(
                          color: AppColors.red,
                        );
                      },
                    );
                    auditionBloc.dispatch(
                      AddToWishlistEvent(
                        addToWishlistRequest: AddToWishlistRequest(
                          agencyid: widget.auditionResponse.user_id,
                          postid: widget.auditionResponse.id,
                        ),
                        completer: Completer()
                          ..future.then(
                            (msg) {
                              if (msg == 'Added to wishlist' ||
                                  msg == 'removed from wishlist') {
                                Navigator.of(context).pop();
                                setState(() {
                                  isAddedInWishlist = !isAddedInWishlist;
                                });
                              }
                            },
                          ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PrimaryText(
                text: "Language",
              ),
              Spaces.h8,
              WrappedList(
                items: widget.auditionResponse.languages.split(',').toList(),
              ),
              Spaces.h32,
              _buildNumberOfArtist(),
              Spaces.h32,
              PrimaryText(
                text: "Expertise",
              ),
              Spaces.h8,
              WrappedList(
                items: widget.auditionResponse.expertise == null
                    ? []
                    : widget.auditionResponse.expertise.split(',').toList(),
              ),
              Spaces.h32,
              PrimaryText(
                text: "Tags",
              ),
              Spaces.h8,
              WrappedList(
                items: widget.auditionResponse.keywords == null
                    ? []
                    : widget.auditionResponse.keywords.split(',').toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberOfArtist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PrimaryText(
            text: "Number of Artists",
          ),
          Spaces.w8,
          Container(
            height: SizeConfig.safeBlockVertical * 8,
            width: SizeConfig.safeBlockVertical * 8,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: PrimaryText(
                text: "${widget.auditionResponse.artist_required}",
                fontSize: AppConstants.HEADING,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _auditionCallValidity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: AppConstants.CARD_ELEVATION,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PrimaryText(text: "Audition Call Validity"),
              Spaces.h8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryText(
                    text: "Last Date",
                  ),
                  Spaces.w8,
                  PrimaryText(
                    text: "${widget.auditionResponse.validity.split(" ")[0]}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppliedButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PrimaryButton(
        size: BUTTON_SIZE.large,
        text: "Applied",
      ),
    );
  }

  List<String> _getImageUrl(String imageUrl) {
    List<String> urlList = imageUrl.split(',').toList();
    List<String> finalUrls = [];
    urlList.forEach((url) {
      finalUrls.add('https://$url');
    });
    return finalUrls;
  }

 Completer _profileResponseCompleter() {
    return Completer()..future.then((agencyProfileResponse){
      Navigator.of(context).pop();
      if(agencyProfileResponse!=null){
        Routes.navigate(Routes.AGENCY_PROFILE_PAGE,params: {ParameterKey.AGENCY_PROFILE_RESPONSE:agencyProfileResponse});
      }
    });
 }
}
