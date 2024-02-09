import 'dart:ffi'; // Import Dart FFI library
import 'dart:io'; // Import 'dart:io' for platform-specific functionality
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path; // Import 'path' from 'path' package

// Path to the 'memory_info.so' file
String pathMemInfo = kDebugMode
    ? path.join(Directory.current.path, 'core/memory_info.so')
    : path.join(
        Directory.current.path,
        'data/flutter_assets/core/memory_info.so',
      );

// Load the shared library from 'memory_info.so' file
DynamicLibrary dylib = DynamicLibrary.open(pathMemInfo);

typedef CPPType = Long
    Function(); // Define typedef for C function which is the return type from the C function
typedef DartType = int
    Function(); // Define typedef for Dart function which is the converted type in Dart

// Look up the C function for 'getMemoryTotal' function
final DartType lookedUpGetMemoryTotal =
    dylib.lookupFunction<CPPType, DartType>('getMemoryTotal');

// Look up the C function for 'getMemoryFree' function
final DartType lookedUpGetMemoryFree =
    dylib.lookupFunction<CPPType, DartType>('getMemoryFree');

// Look up the C function for 'getSwapTotal' function
final DartType lookedUpGetSwapTotal =
    dylib.lookupFunction<CPPType, DartType>('getSwapTotal');

// Look up the C function for 'getSwapFree' function
final DartType lookedUpGetSwapFree =
    dylib.lookupFunction<CPPType, DartType>('getSwapFree');

// Look up the C function for 'getSwapUsed' function
final DartType lookedUpGetSwapUsed =
    dylib.lookupFunction<CPPType, DartType>('getSwapUsed');

// Look up the C function for 'getBuffers' function
final DartType lookedUpGetBuffers =
    dylib.lookupFunction<CPPType, DartType>('getBuffers');

// Look up the C function for 'getCached' function
final DartType lookedUpGetCached =
    dylib.lookupFunction<CPPType, DartType>('getCached');

// Look up the C function for 'getShmem' function
final DartType lookedUpGetShmem =
    dylib.lookupFunction<CPPType, DartType>('getShmem');

// Look up the C function for 'getSReclaimable' function
final DartType lookedUpGetSReclaimable =
    dylib.lookupFunction<CPPType, DartType>('getSReclaimable');

class MemoryInfo {
  static int get memoryTotal => lookedUpGetMemoryTotal();

  static int get memoryFree => lookedUpGetMemoryFree();

  static int get swapTotal => lookedUpGetSwapTotal();

  static int get swapFree => lookedUpGetSwapFree();

  static int get swapUsed => lookedUpGetSwapUsed();

  static int get buffers => lookedUpGetBuffers();

  static int get cached => lookedUpGetCached();

  static int get shmem => lookedUpGetShmem();

  static int get sReclaimable => lookedUpGetSReclaimable();
}
