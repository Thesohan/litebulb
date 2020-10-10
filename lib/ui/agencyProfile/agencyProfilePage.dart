import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc.dart';
import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/imageAssets.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/ui/agencyProfile/agencyAbout.dart';
import 'package:new_artist_project/ui/agencyProfile/agencyAuditions.dart';
import 'package:new_artist_project/ui/agencyProfile/agencyOwner.dart';
import 'package:new_artist_project/ui/agencyProfile/agency_project.dart';
import 'package:new_artist_project/ui/widgets/primary_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';
import 'package:provider/provider.dart';

class AgencyProfilePage extends StatefulWidget {
  final AgencyProfileResponse agencyProfileResponse;

  const AgencyProfilePage({Key key, @required this.agencyProfileResponse})
      : assert(agencyProfileResponse != null),
        super(key: key);
  @override
  _AgencyProfilePageState createState() => _AgencyProfilePageState();
}

class _AgencyProfilePageState extends State<AgencyProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  AuditionBloc _auditionBloc;
  @override
  void didChangeDependencies() {
    _auditionBloc = Provider.of<AuditionBloc>(context);
    super.didChangeDependencies();
  }

  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildSliverAppBar(context),
              _buildSliverPersistentHeader(context),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              AgencyOwner(
                agencyProfileResponse: widget.agencyProfileResponse,
              ),
              AgencyAbout(
                auditionBloc: _auditionBloc,
                agencyProfileResponse: widget.agencyProfileResponse,
              ),
              AgencyAuditions(
                auditionBloc: _auditionBloc,
                agencyProfileResponse: widget.agencyProfileResponse,
              ),
              AgencyProject(
                agencyProfileResponse: widget.agencyProfileResponse,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _buildSliverPersistentHeader(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          isScrollable: false,
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * AppConstants.NORMAL,
              fontFamily: 'Montserrat.Medium'),
          tabs: [
            Tab(
              text: "Owner",
            ),
            Tab(text: "About"),
            Tab(text: "Auditions"),
            Tab(text: 'Projects'),
          ],
        ),
      ),
      pinned: false,
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: PrimaryText(
          text: "${widget.agencyProfileResponse.name}",
          color: AppColors.white,
        ),
        background: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: SizeConfig.safeBlockVertical * 16,
                width: SizeConfig.safeBlockVertical * 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image: DecorationImage(
                    image: widget.agencyProfileResponse.avatar_loc == null
                        ? AssetImage(ImageAssets.DANCE)
                        : NetworkImage(
                            "https://${widget.agencyProfileResponse.avatar_loc}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10.0,
              bottom: 0.0,
              child: PrimaryButton(
                text: 'Block',
                textColor: AppColors.red,
                onPressed: () {
                  AgencyProfileBloc agencyProfileBloc =
                      Provider.of<AgencyProfileBloc>(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return SpinKitFadingCircle(
                        color: AppColors.red,
                      );
                    },
                  );
                  agencyProfileBloc.dispatch(
                    BlockOrUnBlockAgencyEvent(
                      isBlocEvent: true,
                      agencyId: widget.agencyProfileResponse.id,
                      completer: _completer(context),
                    ),
                  );
                },
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Completer _completer(BuildContext context) {
    return Completer()
      ..future.then(
        (msg) {
          /// popping dialog
          Navigator.of(context).pop();
          if (msg == 'Added to the blocked list') {
            Navigator.of(context).pop();
          }
        },
      );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: AppColors.primary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
