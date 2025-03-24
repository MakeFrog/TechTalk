import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/route_extension.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/question_creation_state.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

mixin class QuestionCreationEvent {
  ///
  /// 면접 시작하기 버튼이 클릭 되었을 때
  ///
  void onStartInterViewBtnTapped(WidgetRef ref) {}

  ///
  /// '질문 고르기' 버튼이 클릭 되었을 때
  ///
  void routeToListedQnasPage(WidgetRef ref) {}

  ///
  /// 백버튼이 클릭 되었을 때
  ///
  void onBackBtnTapped(WidgetRef ref) {
    final isQuestionCreated = QuestionCreationState().hasQuestionCreated(ref);

    if (isQuestionCreated) {
    } else {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          showContentImg: false,
          title: '질문을 만드는 중이에요!',
          description: '지금 나가면 면접을 위한 질문이 사라질 수 있어요\n정말 나가시겠어요?',
          leftBtnContent: '나가기',
          rightBtnContent: '면접 진행하기',
          onRightBtnClicked: () {
            ref.context.pop();
          },
          onLeftBtnClicked: () {
            if (QuestionCreationState().hasQuestionCreated(ref)) {
              SnackBarService.showSnackBar('잠깐! 방금 질문이 생성 되었어요');
              ref.context.pop();
            } else {
              GoRouter.of(ref.context).popUntilPath(MainRoute.path);
            }
          },
        ),
      );
    }
  }
}
