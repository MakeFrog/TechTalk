import 'package:flutter/material.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';

class ChatViewModel extends BaseViewModel {
  /* State Variables */
  int selectedTabIndex = 0;

  /* Controllers  */
  late final TextEditingController textEditingController;

  /* Intents */

  /// 상단 탭이 클릭 되었을 때
  void onTabTapped(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  /// TextField에 글자가 입력 되었을 때
  void onFieldChanged(String term) {
    notifyListeners();
  }

  /* Getters */
  bool get isTextField => textEditingController.text.isNotEmpty;

  @override
  void onInit() {
    textEditingController = TextEditingController();

    print("ONINT ACTIVATED");
  }

  @override
  void onDispose() {
    textEditingController.dispose();
  }
}
