import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: FittedBox(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push('/sampleScreen1');
                },
                child: const Text('Route to SampleScreen1'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/sampleScreen2');
                },
                child: const Text('Route to SampleScreen2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
