import 'package:fluttertoast/fluttertoast.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

class ToastService {
  factory ToastService() => _instance;
  ToastService._();
  static final ToastService _instance = ToastService._();

  final FToast _fToast = FToast()..init(rootNavigatorKey.currentContext!);

  void show({
    required CustomToast toast,
  }) {
    _fToast.showToast(
      child: toast,
    );
  }
}
