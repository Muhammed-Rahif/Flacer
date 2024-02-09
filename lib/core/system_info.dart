import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import "package:ffi/ffi.dart";

String getLibraryPath() {
  return kDebugMode
      ? path.join(Directory.current.path, 'core/system_info.so')
      : path.join(
          Directory.current.path,
          'data/flutter_assets/core/system_info.so',
        );
}

typedef CPPType = Pointer<Utf8>
    Function(); // Define typedef for C function which is the return type from the C function
typedef DartType = Pointer<Utf8>
    Function(); // Define typedef for Dart function which is the converted type in Dart

DynamicLibrary loadLibrary() {
  String pathCpuInfo = getLibraryPath();
  return DynamicLibrary.open(pathCpuInfo);
}

final DynamicLibrary dylib = loadLibrary();

final getHostname = dylib.lookupFunction<CPPType, DartType>('getHostname');

final getPlatform = dylib.lookupFunction<CPPType, DartType>('getPlatform');

final getDistribution =
    dylib.lookupFunction<CPPType, DartType>('getDistribution');

final getKernelRelease =
    dylib.lookupFunction<CPPType, DartType>('getKernelRelease');

final getCPUModel = dylib.lookupFunction<CPPType, DartType>('getCPUModel');

final getCPUCoreCount =
    dylib.lookupFunction<CPPType, DartType>('getCPUCoreCount');

final getCPUSpeed = dylib.lookupFunction<CPPType, DartType>('getCPUSpeed');

class SystemInfo {
  static String get hostname => getHostname().toDartString();
  static String get platform => getPlatform().toDartString();
  static String get distribution => getDistribution().toDartString();
  static String get kernelRelease => getKernelRelease().toDartString();
  static String get cpuModel => getCPUModel().toDartString();
  static String get cpuCoreCount => getCPUCoreCount().toDartString();
  static String get cpuSpeed => getCPUSpeed().toDartString();
}
