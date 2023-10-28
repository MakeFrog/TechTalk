import 'package:flutter/foundation.dart';

abstract class BaseNoNetworkingUseCase<REQUEST, RESPONSE> {
  RESPONSE call(REQUEST param);

  BaseNoNetworkingUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
