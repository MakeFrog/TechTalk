class SampleRepository {
  Future<String> someRepoMethod() async {
    await Future.delayed(const Duration(seconds: 2));
    return "SOME VALUE";
  }
}
