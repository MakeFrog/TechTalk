import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'study_qnas_provider.g.dart';

@riverpod
class StudyQnas extends _$StudyQnas {
  @override
  FutureOr<List<QnaEntity>> build(String topicId) async {
    return (await getTopicQnasUseCase(topicId)).getOrThrow();
  }
}
