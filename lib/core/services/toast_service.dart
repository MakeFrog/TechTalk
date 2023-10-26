import 'package:fluttertoast/fluttertoast.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

class ToastService {
  ToastService._();

  static final FToast _fToast = FToast()
    ..init(rootNavigatorKey.currentContext!);

  static void show({
    required CustomToast toast,
    bool afterDispose = false,
  }) {
    if (afterDispose) {
      _fToast.removeQueuedCustomToasts();
    }

    _fToast.showToast(
      child: toast,
    );
  }
}
