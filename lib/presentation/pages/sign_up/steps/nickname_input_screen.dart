import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_introduction.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class NicknameInputScreen extends ConsumerWidget {
  const NicknameInputScreen({super.key});

  Future<void> _onTapNext(WidgetRef ref) async {
    await ref.read(appUserAuthProvider.notifier).signOut();
//     final db = FirebaseFirestore.instance;
//     // Create a new user with a first and last name
//     final user = <String, dynamic>{
//       "first": "Alan",
//       "middle": "Mathison",
//       "last": "Turing",
//       "born": 1912
//     };
//
// // Add a new document with a generated ID
//     db.collection("users").add(user).then((DocumentReference doc) =>
//         print('DocumentSnapshot added with ID: ${doc.id}'));
//
//     await db.collection("users").get().then((event) {
//       for (var doc in event.docs) {
//         print("${doc.id} => ${doc.data()}");
//       }
//     });
// // // Add a new document with a generated ID
// //     await db.collection("users").add(user).then(
// //           (DocumentReference doc) => print(
// //             'DocumentSnapshot added with ID: ${doc.id}',
// //           ),
// //         );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SignUpStepIntroduction(
            title: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
            subTitle: '먼저 사용할 닉네임이 필요해요.',
          ),
          const HeightBox(56),
          const ClearableTextFormField(
            inputDecoration: InputDecoration(
              hintText: '닉네임을 입력해 주세요',
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () => _onTapNext(ref),
            child: const Text('다음'),
          ),
        ],
      ),
    );
  }
}
