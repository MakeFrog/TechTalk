import 'package:flutter/foundation.dart';

abstract class BaseNoNetworkingUseCase<REQUEST, RESPONSE> {
  RESPONSE intent(REQUEST param);

  BaseNoNetworkingUseCase() {
    onInit();
  }

  @protected
  void onInit() {}
}
