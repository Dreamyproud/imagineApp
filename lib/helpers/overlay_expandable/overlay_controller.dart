import 'package:flutter/material.dart';

/// A controller used to expand or collapse the bottom sheet of a
/// [overlayExpandable]. Listeners can be added to respond to expand and collapse
/// events. The expanded or collapsed state can also be determined through this
/// controller.
class OverlayController {
  AnimationController _animationController;
  final _listeners = <Function>[];

  /// Only returns [true] if the bottom sheet if fully collapsed
  bool get isCollapsed => _animationController?.value == 0.0;

  /// Only returns [true] if the bottom sheet if fully expanded
  bool get isExpanded => _animationController?.value == 1.0;

  /// Adds a function to be called on every animation frame
  void addListener(Function listener) => _listeners.add(listener);

  /// Used internally to assign the [AnimationController] created by a
  /// [overlayExpandable] to this controller. Unless you're using advanced
  /// animation techniques, you probably won't ever need to use this method.
  void attach(AnimationController animationController) {
    _animationController?.removeListener(_listener);
    _animationController = animationController;
    _animationController?.addListener(_listener);
  }

  /// Collapse the bottom sheet built by [overlayExpandable]
  TickerFuture collapse() => _animationController?.fling(velocity: -1.0);

  /// Removes all previously added listeners
  void dispose() =>
      _listeners.forEach((f) => _animationController?.removeListener(f));

  /// Expand the bottom sheet built by [overlayExpandable]
  TickerFuture expand() => _animationController?.fling(velocity: 1.0);

  /// Remove a previously added listener
  void removeListener(Function listener) => _listeners.remove(listener);

  void _listener() => _listeners.forEach((f) => f?.call());
}
