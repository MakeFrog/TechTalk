import 'package:flutter/cupertino.dart';

/** Created By Ximya - 2023.08.08
 * 이미지의 캐시 크기를 계산하는 확장(extension). 이 확장은 주어진 double,int 값에
 * 기반하여 이미지의 크기를 캐시 크기로 변환함.
 * 디바이스의 픽셀 비율을 고려하여 다양한 해상도에서 일관된 화질을 유지합니다.
 *
 * 사용 방법:
 * double imageWidth = 100.0;
 * int cachedWidth = imageWidth.cacheSize(context);
 *
 * int imageHeight = 200;
 * int cachedHeight = imageHeight.cacheSize(context);
 *
 * context 캐시 크기를 계산하는 데 사용되는 BuildContext.
 * 주어진 double,int 값에 디바이스의 픽셀 비율을 곱하고, 가장 가까운 정수로 반올림한 값을 반환합니다.
 *
 *
 * 레퍼런스 : https://github.com/flutter/flutter/issues/56239
 */

extension CachedImgSizeDoubleExtension on double {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

extension CachedImgSizeIntExtension on int {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
