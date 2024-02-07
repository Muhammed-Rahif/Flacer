import 'package:flacer/constants/app.dart';
import 'package:flacer/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  await YaruWindow.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();

  runApp(const FlacerApp());
}

class FlacerApp extends StatelessWidget {
  const FlacerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) {
        return MaterialApp(
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          home: const App(),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YaruMasterDetailPage(
        length: AppRoutesConfig.routePages.length,
        appBar: const YaruWindowTitleBar(title: Text(AppData.name)),
        tileBuilder: (context, index, selected, _) {
          IconData? routesIcon = AppRoutesConfig
              .routesIcons[AppRoutesConfig.routePages.keys.elementAt(index)];

          return YaruMasterTile(
            leading: Icon(routesIcon),
            title: Text(AppRoutesConfig.routePages.keys.elementAt(index)),
            selected: selected,
          );
        },
        pageBuilder: (context, index) {
          Widget routePage = AppRoutesConfig.routePages.values.elementAt(index);

          return routePage;
        },
      ),
    );
  }
}
