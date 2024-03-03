import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';

///
/// 앱의 화면 페이지를 생성하는 유틸리티 클래스
///

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///
    /// Swipe Back 제스처 이벤트를 관리
    /// [preventSwipeBack]의 속성 값은 통해
    /// 플랫폼별 Swipe Back 제스쳐 작동 여부를 설정할 수 있음.
    ///
    return ConditionalWillPopScope(
      shouldAddCallback: preventSwipeBack,
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: !preventAutoUnfocus
            ? () => FocusManager.instance.primaryFocus?.unfocus()
            : null,
        child: Container(
          color: unSafeAreaColor,
          child: wrapWithSafeArea
              ? SafeArea(
                  top: setTopSafeArea,
                  bottom: setBottomSafeArea,
                  child: _buildScaffold(context),
                )
              : _buildScaffold(context),
        ),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildPage(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  /// 하단 네비게이션 바를 구성하는 위젯을 반환
  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// 화면 페이지의 본문을 구성하는 위젯을 반환
  @protected
  Widget buildPage(BuildContext context);

  /// 화면 상단에 표시될 앱 바를 구성하는 위젯을 반환
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// 화면에 표시될 플로팅 액션 버튼을 구성하는 위젯을 반환
  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

  /// 뷰의 안전 영역 밖의 배경색을 설정
  @protected
  Color? get unSafeAreaColor => AppColor.of.white;

  /// 키보드가 화면 하단에 올라왔을 때 페이지의 크기를 조정하는 여부를 설정
  @protected
  bool get resizeToAvoidBottomInset => true;

  /// 플로팅 액션 버튼의 위치를 설정
  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// 앱 바 아래의 콘텐츠가 앱 바 뒤로 표시되는지 여부를 설정
  @protected
  bool get extendBodyBehindAppBar => false;

  /// Swipe Back 제스처 동작을 막는지 여부를 설정
  @protected
  bool get preventSwipeBack => false;

  /// 화면의 배경색을 설정
  @protected
  Color? get screenBackgroundColor => AppColor.of.white;

  /// SafeArea로 감싸는 여부를 설정
  @protected
  bool get wrapWithSafeArea => true;

  /// 뷰의 안전 영역 아래에 SafeArea를 적용할지 여부를 설정
  @protected
  bool get setBottomSafeArea => true;

  /// 뷰의 안전 영역 위에 SafeArea를 적용할지 여부를 설정
  @protected
  bool get setTopSafeArea => true;

  /// 화면 클릭 시 자동으로 포커스를 해제할지 여부를 설정
  @protected
  bool get preventAutoUnfocus => false;
}
