import 'package:moon_dap/app/routes/go_route_with_binding.dart';
import 'package:moon_dap/domain/repository/sample_reposiotry.dart';
import 'package:moon_dap/domain/useCase/sample_use_case.dart';
import 'package:moon_dap/main.dart';

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
