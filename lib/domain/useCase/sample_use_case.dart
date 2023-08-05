import 'package:techtalk/domain/repository/sample_reposiotry.dart';

class SampleUseCase {
  final SampleRepository _sampleRepository;

  SampleUseCase(this._sampleRepository);

  Future<String> sampleUseCase() async {
    return _sampleRepository.someRepoMethod();
  }
}
