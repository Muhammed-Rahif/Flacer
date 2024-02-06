import 'package:flacer/info/memory_info.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(const MyApp());
}

class AppTheme {
  static YaruThemeData of(BuildContext context) {
    return SharedAppData.getValue(
      context,
      'theme',
      () => const YaruThemeData(),
    );
  }

  static void apply(
    BuildContext context, {
    YaruVariant? variant,
    bool? highContrast,
    ThemeMode? themeMode,
  }) {
    SharedAppData.setValue(
      context,
      'theme',
      AppTheme.of(context).copyWith(
        themeMode: themeMode,
        variant: variant,
        highContrast: highContrast,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      data: const YaruThemeData(
        useMaterial3: true,
        themeMode: ThemeMode.system,
      ),
      builder: (context, yaru, child) {
        return MaterialApp(
          theme: yaru.theme,
          title: 'Flacer',
          home: Builder(
            builder: (context) => YaruTheme(
              data: AppTheme.of(context),
              child: const HomePage(),
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _memoryTotal = "No info!";

  /* https://access.redhat.com/solutions/406773
  *
  * https://stackoverflow.com/questions/41224738/
  *   Total used memory = MemTotal - MemFree
  *   Non cache/buffer memory (green) = Total used memory - (Buffers + Cached memory)
  *   Buffers (blue) = Buffers
  *   Cached memory (yellow) = Cached + SReclaimable - Shmem
  *   Swap = SwapTotal - SwapFree
  *
  * Meaning:
  *   cached = (cached + sreclaimable - shmem);
  *   memUsed = (memTotal - (memFree + buffers + cached));
  *   swapUsed = (swapTotal - swapFree);
  */

  void _onBtnClick() {
    final memoryTotal = MemoryInfo.getMemoryTotal();
    final memoryFree = MemoryInfo.getMemoryFree();
    final memoryCached = MemoryInfo.getCached();
    final memoryBuffers = MemoryInfo.getBuffers();

    final actualMemoryUsed =
        memoryTotal - (memoryFree + memoryBuffers + memoryCached);

    print('Memory Total: $memoryTotal');
    print('Memory Free: $memoryFree');
    print('Memory Cached: $memoryCached');
    print('Memory Buffers: $memoryBuffers');
    print('Memory Used: $actualMemoryUsed');

    setState(() {
      _memoryTotal =
          'Memory used: ${actualMemoryUsed ~/ 1024} MB, ${((actualMemoryUsed / memoryTotal) * 100).toInt()}%';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have:',
            ),
            Text(
              _memoryTotal,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onBtnClick,
        tooltip: 'Memory Info',
        child: const Icon(Icons.info),
      ),
    );
  }
}
