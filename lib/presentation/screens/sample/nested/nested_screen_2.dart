import 'package:flutter/material.dart';

class NestedScreen2 extends StatelessWidget {
  const NestedScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedScreen2'),
      ),
      body: const Placeholder(),
    );
  }
}
