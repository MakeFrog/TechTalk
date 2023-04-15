import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';

class SampleViewModel extends BaseViewModel {
  void routeToNestedScreen(BuildContext context) {
    context.push('/sampleScreen1/nestedScreen1');
  }


  @override
  void onDispose() {
    super.onDispose();
    print("VIEW MODEL CLOSED");
  }


  @override
  void onInit() {
    super.onInit();
    print("VIEW MODEL INIT");
  }
}
