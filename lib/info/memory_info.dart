import 'dart:ffi'; // Import Dart FFI library
import 'dart:io'; // Import 'dart:io' for platform-specific functionality
import 'package:path/path.dart' as path; // Import 'path' from 'path' package

// Path to the memory_info.so
String pathMemInfo = path.join(
  Directory.current.path,
  'core/memory_info/memory_info.so',
);

// Load the shared library
DynamicLibrary dylib = DynamicLibrary.open(pathMemInfo);

typedef GetMemoryTotalC = Long Function(); // Define typedef for C function
typedef GetMemoryTotalDart = int Function(); // Define typedef for Dart function

// Look up the C function
final GetMemoryTotalDart getMemoryTotal =
    dylib.lookupFunction<GetMemoryTotalC, GetMemoryTotalDart>('getMemoryTotal');
