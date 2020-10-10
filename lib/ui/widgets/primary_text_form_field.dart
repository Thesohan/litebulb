import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/appConstants.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';
import 'package:new_artist_project/util/size_config.dart';

typedef OnSaved = void Function(String value);
typedef Validator = void Function(String value);

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField(
      {this.validator,
      this.onSaved,
      this.textInputType,
      this.icon,
      this.hintText,
      this.isObscure = false,
      this.labelText,
      this.maxChar,
      this.title,
        this.maxLines=1,
      this.textEditingController});

  final int maxChar;
  final String title;
  final String labelText;
  final Validator validator;
  final OnSaved onSaved;
  final TextInputType textInputType;
  final Icon icon;
  final int maxLines;
  final String hintText;
  final bool isObscure;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        this.title != null ? PrimaryText(text: this.title) : Container(),
        TextFormField(
          autofocus: false,
          controller: this.textEditingController,
          maxLength: this.maxChar,
          obscureText: this.isObscure,
          maxLines: this.maxLines,
          keyboardType: this.textInputType,
          decoration: InputDecoration(
            icon: this.icon,
            labelText: this.labelText,
            enabledBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.pink,
              ),
            ),
            hintText: this.hintText,
            hintStyle: TextStyle(
              color: AppColors.hintColor,
              fontSize: SizeConfig.safeBlockHorizontal * AppConstants.NORMAL,
            ),
          ),
          validator: this.validator,
          onSaved: this.onSaved,
        ),
      ],
    );
  }
}
