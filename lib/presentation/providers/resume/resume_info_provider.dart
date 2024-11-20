import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resume_info_provider.g.dart';

@Riverpod(keepAlive: true)
class ResumeInfo extends _$ResumeInfo {
  // 반드시 필요한 build 메서드 정의
  @override
  String build() {
    return 'Default Resume Info';
  }
}
