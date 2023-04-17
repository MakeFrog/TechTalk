import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


/** Created By Ximya - 2023.02.26
 *  디비이스 크기를 detect하여 반응형 레이아웃 구성하는 모듈
 *  태블릿 디바이스인 경우 375 * 812 크기를 가지며
 *  가운데 정렬이 됨
 * */

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder(this.context, this.child, {super.key});

  final BuildContext context;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          EasyLoading.init()(context, child);
          // 태블릿 디바이스일 경우
          return Stack(
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
        } else {
          // 태블릿 디바이스가 아닐 경우
          return EasyLoading.init()(context, child); // Easy 로딩 컨텐츠스트 초기화
        }
      },
    );
  }
}
