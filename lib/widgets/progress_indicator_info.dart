import 'package:flacer/utils/arc_painter.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class ProgressIndicatorInfo extends StatefulWidget {
  const ProgressIndicatorInfo({
    Key? key,
    required this.child,
    required this.header,
    required this.value,
  }) : super(key: key);

  final Widget child;
  final Widget header;
  final double value;

  @override
  ProgressIndicatorInfoState createState() => ProgressIndicatorInfoState();
}

class ProgressIndicatorInfoState extends State<ProgressIndicatorInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressIndicatorInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _animation =
          Tween<double>(begin: oldWidget.value, end: widget.value).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ),
      );
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = YaruTheme.of(context).variant!.color;
    final trackColor = YaruTheme.of(context).variant!.color.withOpacity(0.25);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ArcPainter(
                    progressColor: progressColor,
                    trackColor: trackColor,
                    animation: _animation,
                  ),
                  child: const AspectRatio(
                    aspectRatio: 2.5,
                    child: SizedBox(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          widget.header,
          widget.child,
        ],
      ),
    );
  }
}
