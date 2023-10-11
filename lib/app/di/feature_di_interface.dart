abstract base class FeatureDependencyInjection {
  void init() {
    dataSources();
    repositories();
    useCases();
  }

  void dataSources();
  void repositories();
  void useCases();
}
