import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  const AnimatedCount({
    Key? key,
    required this.count,
    this.style,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.fastOutSlowIn,
    this.prefix = '',
    this.suffix = '',
  }) : super(duration: duration, curve: curve, key: key);

  final num count;
  final String prefix;
  final String suffix;
  final TextStyle? style;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedCountState();
  }
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _intCount = IntTween(begin: 0, end: 1);
  Tween<double> _doubleCount = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    if (widget.count is int) {
      _intCount = IntTween(begin: 0, end: widget.count.toInt());
    } else {
      _doubleCount = Tween<double>(begin: 0, end: widget.count.toDouble());
    }
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final String text;
    if (widget.count is int) {
      final countStr = _intCount.evaluate(animation).toString();
      text = '${widget.prefix}$countStr${widget.suffix}';
    } else {
      final countStr = _doubleCount.evaluate(animation).toStringAsFixed(1);
      text = '${widget.prefix}$countStr${widget.suffix}';
    }

    return Text(text, style: widget.style);
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
