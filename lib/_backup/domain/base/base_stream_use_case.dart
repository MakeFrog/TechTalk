import 'package:flutter/foundation.dart';

abstract class BaseStreamUseCase<REQUEST, RESPONSE> {
  Stream<RESPONSE> call(REQUEST request);

  BaseStreamUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
