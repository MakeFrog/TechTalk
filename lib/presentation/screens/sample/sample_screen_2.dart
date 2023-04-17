import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SampleScreen2 extends StatelessWidget {
  const SampleScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SampleScreen2'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.push('/sampleScreen2/nestedScreen2');
            },
            child: const Text('Route To NestedScreen 2')),
      ),
    );
  }
}



