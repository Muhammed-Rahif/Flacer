import 'package:flacer/utils/arc_painter.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class ProgressIndicatorInfo extends StatelessWidget {
  const ProgressIndicatorInfo({
    super.key,
    required this.textCenter,
    required this.textBottom,
    required this.value,
  });

  final String textCenter;
  final String textBottom;
  final double value;

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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: ArcPainter(
                  progressColor: progressColor,
                  trackColor: trackColor,
                  value: value,
                ),
                child: const AspectRatio(
                  aspectRatio: 2,
                  child: SizedBox(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(textCenter),
          Text(textBottom),
        ],
      ),
    );
  }
}
