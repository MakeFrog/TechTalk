import 'package:fluttertoast/fluttertoast.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

class ToastService {
  ToastService._();

  static final FToast _fToast = FToast()
    ..init(rootNavigatorKey.currentContext!);

  static void show({
    required CustomToast toast,
  }) {
    _fToast.showToast(
      child: toast,
    );
  }
}
