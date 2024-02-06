import 'dart:ffi'; // Import Dart FFI library
import 'dart:io'; // Import 'dart:io' for platform-specific functionality
import 'package:path/path.dart' as path; // Import 'path' from 'path' package

// Path to the 'memory_info.so' file
String pathMemInfo = path.join(Directory.current.path, 'core/memory_info.so');

// Load the shared library from 'memory_info.so' file
DynamicLibrary dylib = DynamicLibrary.open(pathMemInfo);

typedef CReturnType = Long
    Function(); // Define typedef for C function which is the return type from the C function
typedef DartConvertType = int
    Function(); // Define typedef for Dart function which is the converted type in Dart

class MemoryInfo {
  static int getMemoryTotal() {
    // Look up the C function for 'getMemoryTotal' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryTotal');

    return lookedUpFunction();
  }

  static int getMemoryFree() {
    // Look up the C function for 'getMemoryFree' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryFree');

    return lookedUpFunction();
  }

  static int getMemoryUsed() {
    // Look up the C function for 'getMemoryUsed' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getMemoryUsed');

    return lookedUpFunction();
  }

  static int getSwapTotal() {
    // Look up the C function for 'getSwapTotal' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapTotal');

    return lookedUpFunction();
  }

  static int getSwapFree() {
    // Look up the C function for 'getSwapFree' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapFree');

    return lookedUpFunction();
  }

  static int getSwapUsed() {
    // Look up the C function for 'getSwapUsed' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSwapUsed');

    return lookedUpFunction();
  }

  static int getBuffers() {
    // Look up the C function for 'getBuffers' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getBuffers');

    return lookedUpFunction();
  }

  static int getCached() {
    // Look up the C function for 'getCached' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getCached');

    return lookedUpFunction();
  }

  static int getShmem() {
    // Look up the C function for 'getShmem' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getShmem');

    return lookedUpFunction();
  }

  static int getSReclaimable() {
    // Look up the C function for 'getSReclaimable' function
    final DartConvertType lookedUpFunction =
        dylib.lookupFunction<CReturnType, DartConvertType>('getSReclaimable');

    return lookedUpFunction();
  }
}
