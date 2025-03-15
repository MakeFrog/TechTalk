import 'package:flutter/material.dart';

abstract final class BottomSheetIntent {
  static Future<T?> showScrollableModalSheet<T>(
    BuildContext context, {
    required Widget scrollableSheet,
  }) async {
    final T? result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return MediaQuery.removeViewInsets(
          context: context,
          removeBottom: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque, // 빈 영역 클릭 감지
            onTap: () => Navigator.pop(context), // 모달 외부 클릭 시 닫기
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {}, // 내부 터치는 이벤트를 소비하지 않도록 처리
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: scrollableSheet,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result;
  }
}

typedef WidgetBuilder = Widget Function(BuildContext context);
