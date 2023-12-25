import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
/// 'useEffect'와  'addPostFrameCallback' 메소드가
///  적용되어 있는 effect 메소드
///
void usePostFrameEffect(Function callback, [List<Object?>? keys]) {
  useEffect(
    () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });

      return null;
    },
    keys,
  );
}
