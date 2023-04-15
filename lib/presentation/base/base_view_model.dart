import 'package:flutter/cupertino.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    onInit();
  }


  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  @protected
  void onInit() {}

  @protected
  void onDispose() {}
}
