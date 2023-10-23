import 'package:flutter/foundation.dart';

abstract class BaseNoFutureUseCase<REQUEST, RESPONSE> {
  RESPONSE call(REQUEST param);

  BaseNoFutureUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
