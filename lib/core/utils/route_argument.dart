class RouteArg {
  static late dynamic argument;

  static void update(dynamic arg) {
    argument = arg;
  }

  static void reset() {
    argument = null;
  }
}
