import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:system_utility/system_utility.dart';

import './utils/utils.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var systemMonitor = SystemMonitor.create();
    Stream<int> cpuUsageStream =
        Utils.toStream(() => systemMonitor.getRAMUsed(), Duration(seconds: 1));

    cpuUsageStream.listen((usage) {
      print(
          '$usage / ${systemMonitor.totalRAM} ${usage * 100 ~/ systemMonitor.totalRAM}%');
    });

    return Scaffold(
      appBar: YaruWindowTitleBar(),
      body: YaruMasterDetailPage(
        length: 2,
        tileBuilder: (context, index, selected, availableWidth) {
          if (index == 0) {
            return YaruMasterTile(title: Text('Page 1'));
          } else {
            return YaruMasterTile(title: Text('Page 2'));
          }
        },
        pageBuilder: (context, index) {
          if (index == 0) {
            return Center(
              child: Text('Hello Ubuntu'),
            );
          } else {
            return Center(
              child: Text('Hello Yaru'),
            );
          }
        },
      ),
    );
  }
}
