enum EnvironmentType {
  dev(type: "DEV", firebaseId: "techtalk-dev-33"),
  prod(type: "PROD", firebaseId: "techtalk-prod-32");

  final String type;
  final String firebaseId;

  const EnvironmentType({
    required this.type,
    required this.firebaseId,
  });
}
