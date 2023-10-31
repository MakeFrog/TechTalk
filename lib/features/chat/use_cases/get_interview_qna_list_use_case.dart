import 'dart:developer';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/features/chat/enums/interview_progress_state.enum.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';

class GetInterviewQnaListUseCase extends BaseUseCase<GetInterviewQnaListParam,
    Result<List<InterviewQnAEntity>>> {
  GetInterviewQnaListUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<InterviewQnAEntity>>> call(
      GetInterviewQnaListParam request) async {
    /// 최초로 QnA 데이터를 불러오는 경우 (최초 채팅방 진입 시)
    if (request.progressState.isInitial) {
      final response = await _repository.getInitialQuestions(request.topic.id);

      /// 가장 첫 번째 질문에 대한 모범 답안 정보 업데이트
      final idealAnswerRes =
          await _repository.getIdealAnswers(response.first.id);

      return idealAnswerRes.fold(
        onSuccess: (idealAnswers) {
          response.first.idealAnswer = idealAnswers;
          return Result.success(response);
        },
        onFailure: (e) {
          log('e');
          return Result.failure(
            Exception(
              '모범 답안을 호출하는데 실패했습니다',
            ),
          );
        },
      );
    }

    /// 기존에 진행 중이던 채팅 데이터를 불러오는 경우
    else {
      return _repository.getOngoingQnaList(request.roomId!);
    }
  }
}

typedef GetInterviewQnaListParam = ({
  InterviewProgressState progressState,
  String? roomId,
  InterviewTopic topic
});
