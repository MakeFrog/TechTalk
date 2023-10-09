abstract class FeatureDependencyInjection {
  FeatureDependencyInjection() {
    _init();
  }

  void _init() {
    dataSources();
    repositories();
    useCases();
  }

  void dataSources();
  void repositories();
  void useCases();
}
