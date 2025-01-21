class Utils {
  static Stream<T> toStream<T>(T Function() function, Duration interval) {
    return Stream.periodic(interval, (_) => function());
  }
}
