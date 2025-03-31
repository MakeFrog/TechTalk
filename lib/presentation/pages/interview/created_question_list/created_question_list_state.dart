import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/created_question_list_rout_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/listed_selectable_qnas_provider.dart';

mixin class CreatedQuestionListState {
  ///
  /// 생성된 질문 리스트
  ///
  AsyncValue<List<SelectableQnaEntity>> createdQuestionAsync(WidgetRef ref) {
    return ref.watch(listedSelectableQnasProviderProvider);
  }
}
