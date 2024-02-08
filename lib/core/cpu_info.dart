import 'dart:ffi'; // Import Dart FFI library
import 'dart:io'; // Import 'dart:io' for platform-specific functionality
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path; // Import 'path' from 'path' package

// Path to the 'cpu_info.so' file
String pathCpuInfo = kDebugMode
    ? path.join(Directory.current.path, 'core/cpu_info.so')
    : path.join(
        Directory.current.path,
        'data/flutter_assets/core/cpu_info.so',
      );

// Load the shared library from 'cpu_info.so' file
DynamicLibrary dylib = DynamicLibrary.open(pathCpuInfo);

/// Look up the C function for 'getProcessCpuUsage' function
final lookedUpGetProcessCpuUsage = dylib
    .lookupFunction<Float Function(), double Function()>('getProcessCpuUsage');

// Look up the C function for 'getCoreCount' function
final lookedUpGetCoreCount =
    dylib.lookupFunction<Int32 Function(), int Function()>('getCoreCount');

class CpuInfo {
  static double get processUsage => lookedUpGetProcessCpuUsage();

  static int get coreCount => lookedUpGetCoreCount();
}
