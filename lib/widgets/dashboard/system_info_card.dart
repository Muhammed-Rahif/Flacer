import 'package:flacer/core/generated_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:ffi/ffi.dart';

String getLibraryPath() {
  return kDebugMode
      ? path.join(Directory.current.path, 'core/system_info.so')
      : path.join(
          Directory.current.path,
          'data/flutter_assets/core/system_info.so',
        );
}

DynamicLibrary loadLibrary() {
  String pathCpuInfo = getLibraryPath();
  return DynamicLibrary.open(pathCpuInfo);
}

final DynamicLibrary dylib = loadLibrary();

class SystemInfoCard extends StatelessWidget {
  const SystemInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text((NativeLibrary(dylib).getHostname().toString())),
    );
  }
}
