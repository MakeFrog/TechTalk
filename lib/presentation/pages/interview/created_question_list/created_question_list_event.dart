import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/listed_selectable_qnas_provider.dart';

mixin class CreatedQuestionListEvent {
  ///
  /// 문답 박스가 클릭 되었을 때
  /// 선택 여부 토글
  ///
  void onQnaBoxTapped(WidgetRef ref, {required SelectableQnaEntity qna}) {
    return ref.read(listedSelectableQnasProviderProvider.notifier).toggle(qna);
  }
}
