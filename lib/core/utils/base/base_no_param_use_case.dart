import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class BaseNoParamUseCase<RESPONSE> {
  FutureOr<RESPONSE> call();

  BaseNoParamUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
