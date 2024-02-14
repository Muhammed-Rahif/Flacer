import 'package:flutter/services.dart';

const platform = MethodChannel('rahif.tech/flacer');

class Internet {
  static Future<String> get name async {
    try {
      final result = await platform.invokeMethod<String>('getInternetName');
      return result ?? 'Unknown';
    } on PlatformException catch (e) {
      print("Failed to get: '${e.message}'.");
    }
    return 'Unknown';
  }
}
