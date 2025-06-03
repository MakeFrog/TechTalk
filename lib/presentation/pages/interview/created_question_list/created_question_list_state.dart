import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/listed_selectable_qnas_provider.dart';

mixin class CreatedQuestionListState {
  ///
  /// 생성된 질문 리스트
  ///
  AsyncValue<List<SelectableQnaEntity>> createdQuestionAsync(WidgetRef ref) {
    return ref.watch(listedSelectableQnasProviderProvider);
  }

  ///
  /// 활성화된 질문 존재 여부
  ///
  bool hasSelectedQuestions(WidgetRef ref) {
    return ref
            .watch(listedSelectableQnasProviderProvider)
            .valueOrNull
            ?.any((e) => e.isSelected) ??
        false;
  }
}
