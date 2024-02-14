import 'dart:async';
import 'dart:math';

import 'package:flacer/core/network.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:yaru/yaru.dart';

List<Color> uploadGradientColors = [
  YaruColors.orange,
  YaruColors.orange,
];
List<Color> downloadGradientColors = [
  YaruColors.blue,
  YaruColors.blue,
];

class NetworkMonitorCard extends StatefulWidget {
  const NetworkMonitorCard({Key? key}) : super(key: key);

  @override
  State<NetworkMonitorCard> createState() => _NetworkMonitorCardState();
}

class _NetworkMonitorCardState extends State<NetworkMonitorCard> {
  List<Point> uploadPoints = [const Point(0, 0)];
  List<Point> downloadPoints = [const Point(0, 0)];
  double x = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final network = await NetworkMonitor.internetSpeed;
      final curntUpload = network.first;
      final curntDownload = network.last;

      setState(() {
        if (!mounted) return;
        uploadPoints.add(Point(x, curntUpload));
        downloadPoints.add(Point(x, curntDownload));

        if (uploadPoints.length > 22) uploadPoints.removeAt(0);
        if (downloadPoints.length > 22) downloadPoints.removeAt(0);

        x += 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14);
    String text;
    text = "${value ~/ 1024}MB";

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1024, // 1KB
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: YaruColors.orange,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: YaruColors.orange,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          axisNameWidget: Text(
              "Download ${downloadPoints.last.y.toStringAsFixed(0)}KB/s, Upload ${uploadPoints.last.y.toStringAsFixed(0)}KB/s"),
          axisNameSize: 26,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1024, // 1MB
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: YaruColors.coolGrey),
      ),
      minX: x - 11,
      maxX: x - .5,
      minY: 0,
      maxY: 2 * 1024, // 6MB
      lineBarsData: [
        LineChartBarData(
          spots: uploadPoints
              .map((p) => FlSpot(p.x.toDouble(), p.y.toDouble()))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(colors: uploadGradientColors),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: uploadGradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
        LineChartBarData(
          spots: downloadPoints
              .map((p) => FlSpot(p.x.toDouble(), p.y.toDouble()))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(colors: downloadGradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: downloadGradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
