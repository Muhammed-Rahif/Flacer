import 'package:flacer/info/memory_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
