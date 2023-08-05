import 'package:go_router/go_router.dart';
import 'package:techtalk/app/routes/go_route_with_binding.dart';
import 'package:techtalk/presentation/screens/chat/chat_binding.dart';
import 'package:techtalk/presentation/screens/chat/chat_screen.dart';
import 'package:techtalk/presentation/screens/sample/nested/nested_screen_1.dart';
import 'package:techtalk/presentation/screens/sample/nested/nested_screen_2.dart';
import 'package:techtalk/presentation/screens/sample/sample_1_binding.dart';
import 'package:techtalk/presentation/screens/sample/sample_screen_2.dart';
import 'package:techtalk/presentation/screens/sample/smaple_screen_1.dart';

abstract class AppPages {
  AppPages._();

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRouteWithBinding(
        path: '/',
        binding: ChatBinding(),
        newBuilder: (context, state) => const ChatScreen(),
      ),
      // GoRouteWithBinding(
      //   path: '/sampleScreen1',
      //   newBuilder: (context, state) => const SampleScreen1(),
      //   prevPath: '/',
      //   binding: SampleBinding(),
      //   routes: [
      //     GoRoute(
      //       path: 'nestedScreen1',
      //       builder: (_, __) => const NestedScreen1(),
      //     ),
      //   ],
      // ),
      GoRoute(
          path: '/sampleScreen2',
          builder: (_, __) {
            print("BUILDER ALWAYS Sparkels");
            return const SampleScreen2();
          },
          routes: [
            GoRoute(
              path: 'nestedScreen2',
              builder: (_, __) => const NestedScreen2(),
            ),
          ]),
    ],
  );
}

class SampleScreen2Binding extends Bindings {
  @override
  void dependencies() {
    print("it binds some method");
  }

  @override
  void unRegister() {
    // TODO: implement unRegister
  }
}
