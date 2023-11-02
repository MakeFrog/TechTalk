import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/core/utils/route_argument.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/features/chat/use_cases/get_interview_qna_list_use_case.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'total_qna_list_provider.g.dart';

@riverpod
class TotalQnaList extends _$TotalQnaList {
  @override
  FutureOr<List<InterviewQnAEntity>> build() async {
    final routeArg = RouteArg.argument as ChatPageRouteArg;

    final GetInterviewQnaListParam param = (
      progressState: routeArg.progressState,
      roomId: routeArg.roomId,
      topic: routeArg.topic,
    );

    final response = await getInterviewQnaListUseCase(param);

    return response.fold(
      onSuccess: (qnaList) {
        return qnaList;
      },
      onFailure: (e) {
        ToastService.show(
          toast: NormalToast(message: '$e'),
        );
        throw e;
      },
    );
  }

  /// [질문]
  /// Riverpod에서 public getter를 사용하는 권장하지 않는데 관련해서 특별한 이유가 있는지 궁금
  ///
  /// 그렇다면
  /// 지금처럼 QnaList라는 데이터에서 특정 필터링한 데이터에 접근하려면 새로운 provider를 만드는게 좋나
  /// 아니면 아래 [completedQnAList] 메소드처럼 새로운 notifier 메소드를 만드는게 좋나?

/*
  List<InterviewQnAEntity> completedQnaList(List<InterviewQnAEntity> list) {
    final filteredList = list.where((e) {
      if (e.hasUserResponded) {
        if (e.response!.state.isCompleted) {
          return true;
        }
      }

      return false;
    }).toList();

    return filteredList;
  }

   */
}
