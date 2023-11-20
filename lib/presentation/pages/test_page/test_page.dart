import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class TestPage extends BasePage {
  const TestPage({Key? key}) : super(key: key);

  @override
  void onInit(WidgetRef? ref) {
    print("화면이 초기화 됨");
  }

  @override
  void onDispose(WidgetRef? ref) {
    print("화면이 없어짐");
  }

  @override
  Color? get screenBackgroundColor => Colors.red;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '페이지 테스트',
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                const ChatPageRoute(
                  progressState: InterviewProgressState.initial,
                  roomId: 'RWNSK@32ASDF3',
                  topic: InterviewTopic.swift,
                ).go(ref.context);
              },
              child: const Text(
                '면접 입장',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                const ChatPageRoute(
                  progressState: InterviewProgressState.ongoing,
                  roomId: 'RWNSK@32ASDF3',
                  topic: InterviewTopic.swift,
                ).push(ref.context);
              },
              child: const Text(
                '진행중인 면접 입장',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
