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

class MemoryInfo {
  static int get memoryTotal {
    // Look up the C function for 'getMemoryTotal' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryTotal');

    return lookedUpFunction();
  }

  static int get memoryFree {
    // Look up the C function for 'getMemoryFree' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryFree');

    return lookedUpFunction();
  }

  static int get memoryUsed {
    // Look up the C function for 'getMemoryUsed' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryUsed');

    return lookedUpFunction();
  }

  static int get swapTotal {
    // Look up the C function for 'getSwapTotal' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapTotal');

    return lookedUpFunction();
  }

  static int get swapFree {
    // Look up the C function for 'getSwapFree' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapFree');

    return lookedUpFunction();
  }

  static int get swapUsed {
    // Look up the C function for 'getSwapUsed' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapUsed');

    return lookedUpFunction();
  }

  static int get buffers {
    // Look up the C function for 'getBuffers' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getBuffers');

    return lookedUpFunction();
  }

  static int get cached {
    // Look up the C function for 'getCached' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getCached');

    return lookedUpFunction();
  }

  static int get shmem {
    // Look up the C function for 'getShmem' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getShmem');

    return lookedUpFunction();
  }

  static int get sReclaimable {
    // Look up the C function for 'getSReclaimable' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSReclaimable');

    return lookedUpFunction();
  }
}
