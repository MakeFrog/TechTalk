import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/interview/use_case/create_proficiency_interview_qna_use_case.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';

part 'created_proficiency_qnas_provider.g.dart';

@riverpod
class CreatedProficiencyQnas extends _$CreatedProficiencyQnas {
  @override
  Future<List<ProficiencyQnaEntity>> build(
      ProficiencyInterviewFlowParam useCaseParam) async {
    final result =
        await CreateProficiencyInterviewQnaUseCase().call(useCaseParam);
    return result;
  }
}
