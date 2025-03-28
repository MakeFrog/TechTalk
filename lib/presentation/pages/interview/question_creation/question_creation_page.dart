import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/constant/question_creation_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/question_creation_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/question_creation_event.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/question_creation_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/button/see_all_question_button.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

part 'widgets/app_bar.p.dart';
part 'widgets/bottom_fixed_button.p.dart';
part 'widgets/illust_view.p.dart';
part 'widgets/leading_view.p.dart';
part 'widgets/scaffold.p.dart';

///
/// 역량별 면접 질문을 선택하는 페이지
///
class QuestionCreationPage extends BasePage with QuestionCreationState {
  const QuestionCreationPage(this.arg, {super.key});

  final QuestionCreationRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      questionCreationRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      leadingView: _LeadingView(),
      illustView: _IllustView(),
    );
  }

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _BottomFixedButton();
  }

  @override
  bool get canPop => false;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;
}
