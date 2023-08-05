import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/resources/uiConfig/color_config.dart';
import 'package:techtalk/presentation/base/base_view_model.dart';
import 'package:provider/provider.dart';

@immutable
abstract class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => createViewModel(),
      lazy: setLazyInit,
      builder: (BuildContext context, Widget? child) {
        return ConditionalWillPopScope(
          shouldAddCallback: preventSwipeBack,
          onWillPop: () async {
            return false;
          },
          child: Container(
            color: unSafeAreaColor,
            child: wrapWithSafeArea
                ? SafeArea(
                    bottom: setBottomSafeArea,
                    child: _buildScaffold(context),
                  )
                : _buildScaffold(context),
          ),
        );
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @protected
  Color? get unSafeAreaColor => AppColor.white;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get preventSwipeBack => false;

  @protected
  Color? get screenBackgroundColor => AppColor.white;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get setLazyInit => false;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }

  @protected
  T createViewModel();
}
