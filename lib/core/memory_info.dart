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

typedef CReturnType = Long
    Function(); // Define typedef for C function which is the return type from the C function
typedef DartConvertType = int
    Function(); // Define typedef for Dart function which is the converted type in Dart

// Look up the C function for 'getMemoryTotal' function
final DartConvertType lookedUpGetMemoryTotal =
    dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryTotal');

// Look up the C function for 'getMemoryFree' function
final DartConvertType lookedUpGetMemoryFree =
    dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryFree');

// Look up the C function for 'getSwapTotal' function
final DartConvertType lookedUpGetSwapTotal =
    dylib.lookupFunction<CReturnType, DartConvertType>('getSwapTotal');

// Look up the C function for 'getSwapFree' function
final DartConvertType lookedUpGetSwapFree =
    dylib.lookupFunction<CReturnType, DartConvertType>('getSwapFree');

// Look up the C function for 'getSwapUsed' function
final DartConvertType lookedUpGetSwapUsed =
    dylib.lookupFunction<CReturnType, DartConvertType>('getSwapUsed');

// Look up the C function for 'getBuffers' function
final DartConvertType lookedUpGetBuffers =
    dylib.lookupFunction<CReturnType, DartConvertType>('getBuffers');

// Look up the C function for 'getCached' function
final DartConvertType lookedUpGetCached =
    dylib.lookupFunction<CReturnType, DartConvertType>('getCached');

// Look up the C function for 'getShmem' function
final DartConvertType lookedUpGetShmem =
    dylib.lookupFunction<CReturnType, DartConvertType>('getShmem');

// Look up the C function for 'getSReclaimable' function
final DartConvertType lookedUpGetSReclaimable =
    dylib.lookupFunction<CReturnType, DartConvertType>('getSReclaimable');

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
