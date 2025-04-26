import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/created_question_list_rout_arg_provider.dart';

part 'listed_selectable_qnas_provider.g.dart';

@Riverpod(dependencies: [createdQuestionListRouteArg])
class ListedSelectableQnasProvider extends _$ListedSelectableQnasProvider {
  @override
  Future<List<SelectableQnaEntity>> build() async {
    final proficiency = ref
        .read(createdQuestionListRouteArgProvider)
        .useCaseParma as ProficiencyInterviewFlowParam;
    final qnas = await proficiency.createdQnasCompleter.future;
    final result = qnas
        ?.map((e) =>
            SelectableQnaEntity<ProficiencyQnaEntity>(isSelected: true, qna: e))
        .toList();
    if (result?.isEmpty ?? true) {
      throw Exception('잘못된 초기화');
    }
    return result!;
  }

  void toggle(SelectableQnaEntity qna) {
    update((prev) {
      final targetIndex = prev.indexWhere((e) => e.qna.id == qna.qna.id);
      if (targetIndex == -1) return prev; // 해당하는 항목이 없으면 변경 없음

      return [
        for (var i = 0; i < prev.length; i++)
          if (i == targetIndex)
            prev[i].copyWith(isSelected: !prev[i].isSelected)
          else
            prev[i]
      ];
    });
  }
}
