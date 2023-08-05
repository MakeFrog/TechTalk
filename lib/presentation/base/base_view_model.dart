import 'package:flutter/cupertino.dart';
import 'package:techtalk/app/routes/go_route_with_binding.dart';

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
