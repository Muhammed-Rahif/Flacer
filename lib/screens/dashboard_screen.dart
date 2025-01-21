import 'package:flacer/widgets/dashboard/system_info_header.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          SystemInfoHeader(),
          FractionallySizedBox(
            widthFactor: .3,
            child: SizedBox(
              height: 300,
              child: YaruBanner(
                child: SizedBox(),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: .38,
            child: SizedBox(
              height: 300,
              child: YaruBanner(
                child: SizedBox(),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: .3,
            child: SizedBox(
              height: 300,
              child: YaruBanner(
                child: SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
