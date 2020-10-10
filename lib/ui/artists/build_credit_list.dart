import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/data/models/artist_credit_model.dart';
import 'package:new_artist_project/routes/parameter_key.dart';
import 'package:new_artist_project/routes/routes.dart';
import 'package:new_artist_project/ui/widgets/primary_divider.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/ui/widgets/title_text.dart';

class BuildCreditList extends StatelessWidget {
  final List<CreditModel> creditModelList;
  final bool isLoggedInArtist;
  const BuildCreditList(
      {Key key, @required this.creditModelList, this.isLoggedInArtist = false})
      : assert(creditModelList != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => _BuildCreditItem(
        artistCreditModel: creditModelList[index],
        isLoggedInArtist: isLoggedInArtist,
      ),
      separatorBuilder: (context, index) => PrimaryDivider(),
      itemCount: creditModelList.length,
    );
  }
}

class _BuildCreditItem extends StatelessWidget {
  final CreditModel artistCreditModel;
  final bool isLoggedInArtist;
  const _BuildCreditItem(
      {Key key, @required this.artistCreditModel, this.isLoggedInArtist})
      : assert(artistCreditModel != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoggedInArtist) {
          Routes.navigate(
            Routes.ADD_CREDITS_PAGE,
            params: {ParameterKey.ARTIST_CREDIT_MODEL: artistCreditModel},
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryText(
                  text: artistCreditModel.award_name,
                  color: AppColors.red,
                  fontSize: AppConstants.SUB_HEADING,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                ),
                PrimaryText(
                  text: artistCreditModel.role,
                  fontSize: AppConstants.NORMAL,
                  maxLines: 1,
                ),
                PrimaryText(
                  fontSize: AppConstants.SMALL,
                  maxLines: 2,
                  text: artistCreditModel.award_details,
                ),
              ],
            ),
            isLoggedInArtist
                ? Icon(
                    Icons.edit,
                    color: AppColors.red,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
