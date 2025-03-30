import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/constant/created_question_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/created_question_list_rout_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/listed_selectable_qnas_provider.dart';

mixin class CreatedQuestionListState {
  ///
  /// 생성된 질문 리스트
  ///
  AsyncValue<List<SelectableQnaEntity>> createdQuestionAsync(WidgetRef ref) {
    return ref.watch(listedSelectableQnasProviderProvider);
  }

  ///
  /// 선택된 질문이 있는지 확인
  ///
  bool hasSelectedQuestions(WidgetRef ref) {
    return ref
            .watch(listedSelectableQnasProviderProvider)
            .valueOrNull
            ?.any((e) => e.isSelected) ??
        false;
  }

  String get noQuestionsText =>
      tr(LocaleKeys.interview_createdQuestion_state_noQuestions);
  String get selectQuestionsText =>
      tr(LocaleKeys.interview_createdQuestion_state_selectQuestions);
  String get maxSelectionText =>
      tr(LocaleKeys.interview_createdQuestion_state_maxSelection);
}
