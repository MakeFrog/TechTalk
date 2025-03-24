import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/created_proficiency_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/proficiency_question_creation_route_arg_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class QuestionCreationState {
  ///
  /// 유저 정보
  ///
  Future<String?> nicknameFuture(WidgetRef ref) async {
    final info = await ref.watch(userInfoProvider.future);
    return info?.nickname;
  }

  ///
  /// 생성된 질문 리스트
  ///
  AsyncValue<List<ProficiencyQnaEntity>> createdQnasAsync(WidgetRef ref) {
    final arg = ref.read(proficiencyRouteArgProvider);

    /// [NOTE]
    /// case 추가되면
    /// 타입 캐스팅하지 않고 switch 문으로 예외처리 할 것
    return ref.watch(createdProficiencyQnasProvider(
        arg.useCaseParam as ProficiencyInterviewFlowParam));
  }

  ///
  /// 면접 질문 생성 여부
  ///
  bool hasQuestionCreated(WidgetRef ref) {
    final targetAsync = createdQnasAsync(ref).valueOrNull;
    return targetAsync != null;
  }
}
