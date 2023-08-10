enum EnvironmentType {
  dev(type: "DEV", url: "https://tyger_dev.com"),
  prod(type: "PROD", url: "https://tyger.com");

  final String type;
  final String url;

  const EnvironmentType({
    required this.type,
    required this.url,
  });
}
