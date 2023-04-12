import 'package:flutter/material.dart';

class NestedScreen1 extends StatelessWidget {
  const NestedScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedScreen1'),
      ),
      body: const Placeholder(),
    );
  }
}
