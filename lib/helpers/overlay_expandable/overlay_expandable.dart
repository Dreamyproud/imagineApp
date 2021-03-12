import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/Colors/color_guide.dart';
import 'package:linkedin/helpers/overlay_expandable/overlay_controller.dart';
import 'package:linkedin/helpers/overlay_expandable/measure_size.dart';
import 'package:linkedin/helpers/skeleton_guide/skeleton_guide.dart';

const VELOCITY_MIN = 320.0;

class OverlayExpandable extends StatefulWidget {
  final List<Widget> children;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  final VoidCallback onClosedPressed;
  final double minHeight;

  OverlayExpandable({
    @required this.children,
    @required this.buttonLabel,
    @required this.onButtonPressed,
    @required this.onClosedPressed,
    this.minHeight = 200,
  })  : assert(children != null),
        assert(buttonLabel != null),
        assert(onButtonPressed != null),
        assert(onClosedPressed != null);

  @override
  _OverlayExpandableState createState() => _OverlayExpandableState();
}

class _OverlayExpandableState extends State<OverlayExpandable>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _velocityTracker = VelocityTracker.withKind(PointerDeviceKind.unknown);

  AnimationController _animationController;
  OverlayController _controller;
  bool _isScrollable = false;

  double _expandedSize = 16.0;
  double get _heightDiff => _expandedSize - widget.minHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _scrollController.addListener(() {
      if (_isScrollable) return;
      _scrollController.jumpTo(0);
    });

    _controller = OverlayController();
    _controller.attach(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) => IgnorePointer(
          ignoring: _controller.isCollapsed,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorsGuide.BG_BLACK.withOpacity(
                _animationController.value *
                    ColorsGuide.BG_BLACK.opacity *
                    0.8),
          ),
        ),
      ),

      _listenerWrap(
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => AnimatedContainer(
            duration: Duration.zero,
            child: SafeArea(
              child: Ink(
                width: double.infinity,
                height: _animationController.value * _heightDiff +
                    widget.minHeight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Card(
                    key: Key('bc-expandable-container-card'),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(),
                    margin: EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                    ),
                    child: Column(
                      children: [
                        _getSwipeLine(),
                        Expanded(child: _getChildrenContainer()),
                        _getButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _getChildrenContainer() => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 16.0,
    ),
    child: ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: widget.children.length,
      itemBuilder: (context, index) => MeasureSize(
        onChange: (Size size) =>
        _expandedSize = _expandedSize + size.height,
        child: widget.children[index],
      ),
    ),
  );

  Widget _getSwipeLine() => MeasureSize(
    onChange: (Size size) => _expandedSize = _expandedSize + size.height,
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SkeletonGuide(
              key: Key('bc-expandable-container-line'),
              height: 4.0,
              size: 48.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: RaisedButton(
            onPressed: widget.onButtonPressed,
            child: Icon(FontAwesomeIcons.userTimes),
          )
        )
      ],
    ),
  );

  Widget _getButton() => MeasureSize(
    onChange: (Size size) => _expandedSize = _expandedSize + size.height,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: RaisedButton(
        onPressed: widget.onButtonPressed,
        child: Text(widget.buttonLabel),
      )
    ),
  );

  void _eventEnd(Velocity velocity) {
    if (_animationController.isAnimating ||
        (_controller.isExpanded && _isScrollable)) {
      return;
    } else if (velocity.pixelsPerSecond.dy.abs() >= VELOCITY_MIN) {
      _animationController.fling(
        velocity: -1 * (velocity.pixelsPerSecond.dy / _heightDiff),
      );
    } else if ((1 - _animationController.value) > _animationController.value) {
      _controller.collapse();
    } else {
      _controller.expand();
    }
  }

  void _eventMove(double dy) {
    if (!_isScrollable) {
      _animationController.value -= dy / _heightDiff;
    }

    if (_controller.isExpanded &&
        _scrollController.hasClients &&
        _scrollController.offset <= 0) {
      setState(() => _isScrollable = dy <= 0);
    }
  }

  Listener _listenerWrap(Widget child) => Listener(
    onPointerSignal: (ps) {
      if (ps is PointerScrollEvent) {
        _eventMove(ps.delta.dy);
      }
    },
    onPointerDown: (event) =>
        _velocityTracker.addPosition(event.timeStamp, event.position),
    onPointerMove: (event) {
      _velocityTracker.addPosition(event.timeStamp, event.position);
      _eventMove(event.delta.dy);
    },
    onPointerUp: (_) => _eventEnd(_velocityTracker.getVelocity()),
    onPointerCancel: (_) => _eventEnd(_velocityTracker.getVelocity()),
    child: child,
  );
}
