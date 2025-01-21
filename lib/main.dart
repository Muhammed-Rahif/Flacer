import 'package:flacer/routes.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:google_fonts/google_fonts.dart';

import './extensions/strings.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
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
          theme: yaru.theme?.copyWith(
            textTheme: Typography.blackHelsinki.apply(
              fontFamily: GoogleFonts.rethinkSans().fontFamily,
            ),
          ),
          darkTheme: yaru.darkTheme?.copyWith(
            textTheme: Typography.whiteHelsinki.apply(
              fontFamily: GoogleFonts.rethinkSans().fontFamily,
            ),
          ),
          home: Scaffold(
            appBar: YaruWindowTitleBar(),
            body: YaruMasterDetailPage(
              length: Routes.all.length,
              tileBuilder: (context, index, selected, availableWidth) {
                return YaruMasterTile(
                  title: Text(Routes.all.keys.elementAt(index).capitalize),
                );
              },
              pageBuilder: (context, index) {
                return Routes.all.values.elementAt(index);
              },
            ),
          ),
        );
      },
    );
  }
}
