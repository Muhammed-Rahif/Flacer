extension StringCasingExtension on String {
  /// https://stackoverflow.com/a/73181790/14781260
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
