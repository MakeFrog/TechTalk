abstract base class FeatureDependencyInjection {
  void init() {
    dataSources();
    repositories();
  }

  void dataSources();
  void repositories();
}
