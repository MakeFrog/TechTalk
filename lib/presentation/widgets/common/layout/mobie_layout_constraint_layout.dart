import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/core/index.dart';

///
/// 일반적인 모바일 디바이스 크기를 넘어가는 디바이스 경우
/// 양 여백을 두고 375 / 812 비율로 화면으로 노출하도록 설정해주는 기본 레이아웃 뷰
///
class MLayoutConstraintLayout extends StatelessWidget {
  const MLayoutConstraintLayout(this.context, this.child, {super.key});

  final BuildContext context;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600 && AppSize.originScreenWidth > 600) {
          // 태블릿 디바이스일 경우
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Colors.black, // 검정색 배경
              ),
              Center(
                child: SizedBox(
                  width: 375, // 가운데 화면의 너비
                  height: 812, // 가운데 화면의 높이
                  child: child,
                ),
              ),
            ],
          );
        }

        return child!;
      },
    );
  }
}
