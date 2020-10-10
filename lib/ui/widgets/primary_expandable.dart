import 'package:flutter/material.dart';
import 'package:new_artist_project/constants/appColors.dart';

/// Listener called when the user taps the toggle button
typedef OnExpandListener(bool isExpanded);

/// Custom expansion card. Opens and closes when the icon is clicked.
/// Why custom? Because the default [ExpansionPanel] doesn't let you change the
/// icon and [ExpansionTile] doesn't let you hide the lines on top/bottom of it.
class PrimaryExpandableCard extends StatefulWidget {
  final Widget body;
  final Widget header;
  final OnExpandListener onExpandListener;
  final Icon icon;
  final bool isExpanded;

  const PrimaryExpandableCard({
    Key key,
    @required this.body,
    @required this.header,
    @required this.onExpandListener,
    @required this.isExpanded,
    this.icon,
  })  : assert(
          onExpandListener != null && isExpanded != null,
        ),
        super(key: key);

  @override
  PrimaryExpandableCardState createState() {
    return new PrimaryExpandableCardState();
  }
}

class PrimaryExpandableCardState extends State<PrimaryExpandableCard>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _animatedController;
  Animation<double> _expansionPanelAnimation;
  Animation<double> _rotationAnimation;

  /// Boolean to state the current expansion state
  /// which will be used to open and close panel
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _isExpanded = widget.isExpanded;

    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..value = _isExpanded ? 1.0 : 0.0;

    _expansionPanelAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animatedController);

    _rotationAnimation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(_animatedController);
  }

  @override
  void didUpdateWidget(PrimaryExpandableCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If there is a request to change the panel i.e. _isExpanded will be set to
    // a different value that it was previously set to.
    if (_isExpanded != widget.isExpanded) {
      if (_isExpanded && !widget.isExpanded) {
        // Currently expanded, need to close it
        _animatedController.reverse(from: _animatedController.value);
      } else if (!_isExpanded && widget.isExpanded) {
        // Currently closed, need to open it
        _animatedController.forward(from: _animatedController.value);
      }

      _isExpanded = widget.isExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              widget.onExpandListener(!widget.isExpanded);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: widget.header ?? Container()),
                  RotationTransition(
                    child: widget.icon ?? Icon(Icons.keyboard_arrow_up),
                    turns: _rotationAnimation,
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            axis: Axis.vertical,
            child: Container(child: widget.body),
            sizeFactor: _expansionPanelAnimation,
          ),
        ],
      ),
    );
  }
}
