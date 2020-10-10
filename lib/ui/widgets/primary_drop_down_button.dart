import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_artist_project/constants/appColors.dart';
import 'package:new_artist_project/constants/spaces.dart';
import 'package:new_artist_project/ui/widgets/primary_text.dart';

typedef OnChange<T>(T value);
typedef ItemBuilder = Widget Function(
  BuildContext context,
  int index,
  bool isSelected,
);

class PrimaryDropDownButton<T> extends StatelessWidget {
  /// items to be displayed in drop down menu
  final List<T> dropDownMenuItems;

  /// title of the drop down menu.
  final String title;

  /// axis of title and dropdown menu items either horizontal or vertical
  /// default value of axis is vertical
  final Axis axis;

  /// this onChange required one parameter of String type i.e selected value of the item.
  /// if this value is null than dropDown will be disabled. And disabled hint will be shown.
  final OnChange onChange;

  /// hint to be shown when dropDownButton is disabled.
  final String disabledHint;

  /// initial selected value of one of the item.
  final T value;

  final bool isExpanded;

  /// Builder called for each item.
  final ItemBuilder itemBuilder;

  /// represents weather this field is required or not
  final bool isRequired;

  PrimaryDropDownButton({
    @required this.dropDownMenuItems,
    this.title,
    @required this.onChange,
    @required this.value,
    @required this.itemBuilder,
    this.disabledHint = "",
    this.isExpanded = true,
    this.axis = Axis.vertical,
    this.isRequired = false,
  })  : assert(dropDownMenuItems != null),
        assert(axis != null),
        assert(value != null),
        assert(itemBuilder != null),
        assert(disabledHint != null);

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical ? _buildColumn(context) : _buildRow(context);
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        this.title != null
            ? PrimaryText(
                text: "${title}${this.isRequired ? " *" : ""}",
              )
            : Container(),
        Spaces.w36,
        Flexible(
          child: DropdownButton(
            value: this.value,
            underline: Container(
              height: 1.0,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.red,
                    width: 0.0,
                  ),
                ),
              ),
            ),
            items: dropDownMenuItems.map<DropdownMenuItem<T>>((T currentValue) {
              Widget child = this.itemBuilder(
                context,
                dropDownMenuItems.indexOf(currentValue),
                this.value == currentValue,
              );
              return DropdownMenuItem<T>(
                value: currentValue,
                child: child,
              );
            }).toList(),
            onChanged: this.onChange,
            isExpanded: this.isExpanded,
            disabledHint: Text(this.disabledHint),
          ),
        ),
      ],
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        this.title != null
            ? PrimaryText(
                text: "${title}${this.isRequired ? " *" : ""}",
              )
            : Container(),
        DropdownButton(
          value: this.value,
          underline: Container(
            height: 1.0,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.red,
                  width: 0.0,
                ),
              ),
            ),
          ),
          items: dropDownMenuItems.map<DropdownMenuItem<T>>((T currentValue) {
            Widget child = this.itemBuilder(
              context,
              dropDownMenuItems.indexOf(currentValue),
              this.value == currentValue,
            );
            return DropdownMenuItem<T>(
              value: currentValue,
              child: child,
            );
          }).toList(),
          onChanged: this.onChange,
          isExpanded: this.isExpanded,
          disabledHint: Text(this.disabledHint),
        ),
      ],
    );
  }
}
