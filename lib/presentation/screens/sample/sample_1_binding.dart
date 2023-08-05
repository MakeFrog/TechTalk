import 'package:techtalk/app/routes/go_route_with_binding.dart';
import 'package:techtalk/domain/repository/sample_reposiotry.dart';
import 'package:techtalk/domain/useCase/sample_use_case.dart';
import 'package:techtalk/main.dart';

class SampleBinding extends Bindings {
  @override
  void dependencies() {
    getIt.registerFactory<SampleRepository>(() => SampleRepository());
    getIt.registerFactory<SampleUseCase>(
        () => SampleUseCase(getIt.get<SampleRepository>()));
  }

  @override
  void unRegister() {
    getIt.unregister<SampleRepository>();
    getIt.unregister<SampleUseCase>();
  }
}
