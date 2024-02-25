import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//
// final listAimProvider = StateProvider<List<String>>((_) {
//   return List.generate(5, (_) => Faker().person.firstName());
// });

part 'test_page.g.dart';

@riverpod
class ListAim extends _$ListAim {
  @override
  List<String> build() {
    return List.generate(5, (_) => Faker().person.firstName());
  }

  void aimUpdate() {
    state = [...state, Faker().person.firstName()];
  }
}

final indexProvider = Provider<int>((_) {
  return 0;
});

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("...page build...");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.red,
              child: Text('9a'),
            ),
          ),
          const TextField(),
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(listAimProvider.notifier).aimUpdate();
        },
      ),
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: ref.watch(listAimProvider.select((value) => value.length)),
        itemBuilder: (_, index) {
          return ProviderScope(
              overrides: [indexProvider.overrideWith((ref) => index)],
              child: const _ListItem());
        });
  }
}

class _ListItem extends ConsumerWidget {
  const _ListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.read(indexProvider);
    final item = ref.watch(listAimProvider)[index];
    print("...list item build...$item");
    return ElevatedButton(
        onPressed: () {
          final list = ref.read(listAimProvider);

          // int index = ref.watch(listAimProvider).indexWhere((element) => element==item);
          list[index] = Faker().person.firstName();
          ref.watch(listAimProvider.notifier).state = [...list];
        },
        child: Text(item));
  }
}
