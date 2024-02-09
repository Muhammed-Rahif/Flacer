import 'package:flacer/core/system_info.dart';
import 'package:flutter/material.dart';

class SystemInfoCard extends StatelessWidget {
  const SystemInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(SystemInfo.hostname),
    );
  }
}
