import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_dap/presentation/screens/home/home_screen.dart';
import 'package:moon_dap/presentation/screens/sample/sample_screen_2.dart';
import 'package:moon_dap/presentation/screens/sample/smaple_screen_1.dart';

abstract class AppPages {
  AppPages._();

  static final router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/sampleScreen1',
      builder: (context, state) => const SampleScreen1(),
    ),
    GoRoute(
      path: '/sampleScreen2',
      builder: (context, state) => const SampleScreen2(),
    )
  ]);
}
