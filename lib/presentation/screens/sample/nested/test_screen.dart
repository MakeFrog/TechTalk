import 'package:flutter/material.dart';

class Palette {
  Color darkGrey = const Color(0xFFBBBAC1);

  Color lightGrey = const Color(0xFF1F1F20);

  Color red = const Color(0xFFFF484E);
}

class SampleScreen32 extends StatelessWidget {
  const SampleScreen32({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Center Title'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: Palette().darkGrey,
            height: 100,
            width: 100,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: Palette().lightGrey,
            height: 100,
            width: 100,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: Palette().red,
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }
}
