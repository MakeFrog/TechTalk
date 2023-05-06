import 'package:flutter/material.dart';

/** Created By Ximya - 2023.02.19
 *  [AutomaticKeepAliveClientMixin] mixin 모듈로
 *  child로 받는 View의 state이 유지될 수 있도록 돕는 모듈
 * */

class KeepAliveView extends StatefulWidget {
  final Widget child;

  const KeepAliveView({Key? key, required this.child}) : super(key: key);

  @override
  State<KeepAliveView> createState() => _KeepAliveViewState();
}

class _KeepAliveViewState extends State<KeepAliveView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
