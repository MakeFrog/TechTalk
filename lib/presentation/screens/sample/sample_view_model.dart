import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_dap/domain/repository/sample_reposiotry.dart';
import 'package:moon_dap/domain/useCase/sample_use_case.dart';
import 'package:moon_dap/main.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';
import 'package:moon_dap/presentation/screens/sample/sample_1_binding.dart';

class SampleViewModel extends BaseViewModel {
  SampleViewModel(this._sampleUseCase);

  final SampleUseCase _sampleUseCase;

  String? someValue;

  void routeToNestedScreen(BuildContext context) {
    context.push('/sampleScreen1/nestedScreen1');
  }

  Future<void> getSomeValue() async {
    await Future.delayed(const Duration(seconds: 2));
    // print("Value startd");
    someValue = await "SAFSDF";
    print("VALUE UPATED ${someValue}");
    notifyListeners();
  }

  @override
  void onDispose() {
    super.onDispose();
    print("VIEW MODEL CLOSED");
    SampleBinding().unRegister();
  }

  @override
  void onInit() {
    super.onInit();
    print("VIEW MODEL INIT");

    getSomeValue();
  }
}
