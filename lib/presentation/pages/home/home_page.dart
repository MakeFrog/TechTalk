import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appUserDataProvider, (_, next) {
      if (next.valueOrNull != null) {
        if (!next.requireValue!.isCompleteSignUp) {
          const SignUpRoute().go(context);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () async {
                  await ref.read(appUserAuthProvider.notifier).signOut();
                },
                icon: FaIcon(
                  FontAwesomeIcons.arrowRightFromBracket,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('test'),
          ),
        ],
      ),
    );
  }
}
