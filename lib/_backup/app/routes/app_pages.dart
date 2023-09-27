import 'package:go_router/go_router.dart';
import 'package:techtalk/_backup/app/routes/go_route_with_binding.dart';
import 'package:techtalk/_backup/presentation/screens/chat/chat_binding.dart';
import 'package:techtalk/_backup/presentation/screens/chat/chat_screen.dart';

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
    ],
  );
}
