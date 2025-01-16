import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract final class AppDevice {
  static late final AndroidDeviceInfo android;
  static late final IosDeviceInfo ios;

  static Future<void> init() async {
    final plugin = DeviceInfoPlugin();

    if (Platform.isIOS) {
      ios = await plugin.iosInfo;
    } else {
      android = await plugin.androidInfo;
    }
  }

  static bool get isIpad {
    if (Platform.isIOS) return false;

    return ios.model.toLowerCase().contains('ipad');
  }
}
