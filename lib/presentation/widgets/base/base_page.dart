import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';

abstract class BasePage extends ConsumerWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConditionalWillPopScope(
      shouldAddCallback: preventSwipeBack,
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: unSafeAreaColor,
        child: wrapWithSafeArea
            ? SafeArea(
                top: setTopSafeArea,
                bottom: setBottomSafeArea,
                child: _buildScaffold(context, ref),
              )
            : _buildScaffold(context, ref),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildPage(context, ref),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @protected
  Color? get unSafeAreaColor => AppColor.of.white;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildPage(BuildContext context, WidgetRef ref);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get preventSwipeBack => false;

  @protected
  Color? get screenBackgroundColor => AppColor.of.white;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get setLazyInit => false;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;
}
