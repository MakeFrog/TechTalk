import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/constant/select_common_question_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/select_common_question_route_arg_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class SelectCommonQuestionPage extends BasePage {
  const SelectCommonQuestionPage({
    super.key,
    required this.arg,
  });

  final SelectCommonQuestionRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      selectCommonQuestionRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
