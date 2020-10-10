import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc.dart';
import 'package:new_artist_project/blocs/audition_bloc/audition_bloc_event.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/data/models/api/request/audition_request.dart';
import 'package:new_artist_project/data/models/api/response/audition_list_response.dart';
import 'package:new_artist_project/data/models/api/response/audition_response.dart';
import 'package:new_artist_project/data/models/category_model.dart';
import 'package:new_artist_project/data/resource.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/auditions/buildAuditionCategory.dart';
import 'package:new_artist_project/ui/auditions/buildFeaturedAuditionList.dart';
import 'package:new_artist_project/ui/widgets/primary_drop_down_button.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:provider/provider.dart';

typedef OnTap = void Function(AuditionRequest auditionModel);

class BuildAuditions extends StatefulWidget {
  final List<CategoryModel> categories;

  const BuildAuditions({Key key, @required this.categories})
      : assert(categories != null),
        super(key: key);

  @override
  _BuildAuditionState createState() {
    return _BuildAuditionState();
  }
}
class _BuildAuditionState extends State<BuildAuditions> {
  List<String> categoryDropdownItems;
  AuditionBloc auditionBloc;
  @override
  void didChangeDependencies() {
    auditionBloc = Provider.of<AuditionBloc>(context);
    auditionBloc.dispatch(
      FetchAgencyAuditionEvent(
        auditionRequest: AuditionRequest(
          agency_id: 'All',
          category: widget.categories[0].id,
          is_featured: '1',
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    categoryDropdownItems = List<String>.generate(widget.categories.length,
        (index) => "${widget.categories[index].name}");

    _selectedCategory = widget.categories[0].name;
    super.initState();
  }

  String _selectedCategory;
  @override
  Widget build(BuildContext context) {
    AuditionBloc _auditionBloc = Provider.of<AuditionBloc>(context);
    return SafeArea(
      child: ListView(
        primary: true,
        children: <Widget>[
          StreamBuilder<Resource<AuditionListResponse>>(
            stream: _auditionBloc.auditionListBehaviourObservable,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.isSuccess) {
                return BuildFeaturedAuditionList(
                  auditionList: snapshot.data.data.data,
                  onTap: (audition) {
                    Routes.navigate(Routes.AUDITION_DETAIL_PAGE, params: {
                      ParameterKey.AUDITION: audition,
                    }).whenComplete(() {
                      auditionBloc.dispatch(
                        FetchAgencyAuditionEvent(
                          auditionRequest: AuditionRequest(
                            agency_id: 'All',
                            category: widget.categories[0].id,
                            is_featured: '1',
                          ),
                        ),
                      );
                    });
                  },
                );
              } else {
                return SpinKitFadingCircle(
                  color: AppColors.red,
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
            child: PrimaryText(
              text: "Apply By Category",
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.HEADING,
            ),
          ),
          _buildCategory(),
          StreamBuilder<Resource<AuditionListResponse>>(
              stream: auditionBloc.activeAuditionBehaviourObservable,
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data.data != null) {
                  List<AuditionResponse> auditionList = snapshot.data.data.data;
                  return BuildAuditionList(
                    auditionResponseList: auditionList,
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: AppColors.red,
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: PrimaryDropDownButton(
        dropDownMenuItems: categoryDropdownItems,
        onChange: (value) {
          setState(() {
            _selectedCategory = value;
            auditionBloc.dispatch(
              FetchAgencyAuditionEvent(
                auditionRequest: AuditionRequest(
                  agency_id: 'All',
                  category: widget
                      .categories[
                          categoryDropdownItems.indexOf(_selectedCategory)]
                      .id,
                  is_featured: '1',
                ),
              ),
            );
          });
        },
        value: _selectedCategory,
        itemBuilder: (context, index, isSelected) {
          return PrimaryText(
            text: categoryDropdownItems[index],
            color: AppColors.red,
            fontSize: AppConstants.SUB_HEADING,
          );
        },
      ),
    );
  }
}
