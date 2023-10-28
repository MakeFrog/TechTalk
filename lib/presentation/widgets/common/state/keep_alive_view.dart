import 'package:flutter/material.dart';

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
