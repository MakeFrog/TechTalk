import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SampleScreen1 extends StatelessWidget {
  const SampleScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SampleScreen1'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Placeholder(),
    );
  }
}
