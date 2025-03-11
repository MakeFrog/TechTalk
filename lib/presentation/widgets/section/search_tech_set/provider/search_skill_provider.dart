import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';

final class SearchSkillNotifier extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  void onDispose() {
    controller.dispose();
  }
}

final searchSkillProvider = AutoDisposeChangeNotifierProvider((ref) {
  final notifier = SearchSkillNotifier();

  ref.onDispose(notifier.onDispose);

  return notifier;
});
