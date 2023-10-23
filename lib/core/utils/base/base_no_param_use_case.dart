import 'package:flutter/foundation.dart';

abstract class BaseNoParamUseCase<RESPONSE> {
  Future<RESPONSE> call();

  BaseNoParamUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
