import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class BaseUseCase<REQUEST, RESPONSE> {
  FutureOr<RESPONSE> call(REQUEST request);

  BaseUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
