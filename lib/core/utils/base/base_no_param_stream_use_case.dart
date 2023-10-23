import 'package:flutter/foundation.dart';

abstract class BaseNoParamStreamUseCase<RESPONSE> {
  Stream<RESPONSE> call();

  BaseNoParamStreamUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
