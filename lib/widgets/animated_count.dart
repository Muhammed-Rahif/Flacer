import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  const AnimatedCount({
    Key? key,
    required this.count,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.fastOutSlowIn,
    this.prefix = '',
    this.suffix = '',
  }) : super(duration: duration, curve: curve, key: key);

  final num count;
  final String prefix;
  final String suffix;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedCountState();
  }
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _intCount = IntTween(begin: 0, end: 1);
  Tween<double> _doubleCount = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return widget.count is int
        ? Text(
            '${widget.prefix}${_intCount.evaluate(animation).toString()}${widget.suffix}',
          )
        : Text(
            '${widget.prefix}${_doubleCount.evaluate(animation).toStringAsFixed(1)}${widget.suffix}',
          );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.count is int) {
      _intCount = visitor(
        _intCount,
        widget.count,
        (dynamic value) => IntTween(begin: value),
      ) as IntTween;
    } else {
      _doubleCount = visitor(
        _doubleCount,
        widget.count,
        (dynamic value) => Tween<double>(begin: value),
      ) as Tween<double>;
    }
  }
}
