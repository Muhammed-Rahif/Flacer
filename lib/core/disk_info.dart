import 'dart:ffi'; // Import Dart FFI library
import 'dart:io'; // Import 'dart:io' for platform-specific functionality
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path; // Import 'path' from 'path' package
import "package:ffi/ffi.dart";

// Path to the 'disk_info.so' file
String pathDiskInfo = kDebugMode
    ? path.join(Directory.current.path, 'core/disk_info.so')
    : path.join(
        Directory.current.path,
        'data/flutter_assets/core/disk_info.so',
      );

// Load the shared library from 'disk_info.so' file
DynamicLibrary dylib = DynamicLibrary.open(pathDiskInfo);

typedef CPPType = UnsignedLongLong Function(
  Pointer<Utf8>?,
); // Define typedef for C function which is the return type from the C function
typedef DartType = int Function(
  Pointer<Utf8>?,
); // Define typedef for Dart function which is the converted type in Dart

/// Look up the C function for 'getTotalDiskSpace' function
final lookedUpGetTotalDiskSpace =
    dylib.lookupFunction<CPPType, DartType>('getTotalDiskSpace');

// Look up the C function for 'getUsedDiskSpace' function
final lookedUpGetUsedDiskSpace =
    dylib.lookupFunction<CPPType, DartType>('getUsedDiskSpace');

// Look up the C function for 'getAvailableDiskSpace' function
final lookedUpGetAvailableDiskSpace =
    dylib.lookupFunction<CPPType, DartType>('getAvailableDiskSpace');

class DiskInfo {
  static int get totalDiskSpace =>
      lookedUpGetTotalDiskSpace('/'.toNativeUtf8());

  static int get usedDiskSpace => lookedUpGetUsedDiskSpace('/'.toNativeUtf8());

  static int get availableDiskSpace =>
      lookedUpGetAvailableDiskSpace('/'.toNativeUtf8());
}
