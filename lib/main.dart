import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  await YaruWindow.ensureInitialized();
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
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YaruMasterDetailPage(
        length: 2,
        appBar: const YaruWindowTitleBar(),
        tileBuilder: (context, index, selected, _) {
          if (index == 0) {
            return const YaruMasterTile(
              leading: Icon(YaruIcons.ubuntu_logo),
              title: Text('Page 1'),
            );
          } else {
            return const YaruMasterTile(
              leading: Icon(YaruIcons.colors),
              title: Text('Page 2'),
            );
          }
        },
        pageBuilder: (context, index) {
          if (index == 0) {
            return const YaruDetailPage(
              appBar: YaruWindowTitleBar(
                title: Text('Page 1'),
              ),
              body: Center(
                child: Text('Hello Ubuntu'),
              ),
            );
          } else {
            return const YaruDetailPage(
              appBar: YaruWindowTitleBar(
                title: Text('Page 2'),
              ),
              body: Center(
                child: Text('Hello Yaru'),
              ),
            );
          }
        },
      ),
    );
  }
}
