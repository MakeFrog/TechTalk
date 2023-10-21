import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source_impl.dart';
import 'package:techtalk/features/sign_up/repositories/sign_up_repository_impl.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

final class SignUpDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I.registerLazySingleton<SignUpRemoteDataSource>(
      SignUpRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    final signUpRemoteDataSource = GetIt.I<SignUpRemoteDataSource>();

    GetIt.I.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(
        signUpRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    final signUpRepository = GetIt.I<SignUpRepository>();
  }
}
