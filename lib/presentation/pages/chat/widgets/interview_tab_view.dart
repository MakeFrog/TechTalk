import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_focus_node_provider.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_input_provider.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_list_provider.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_scroll_controller_provider.dart';
import 'package:techtalk/presentation/pages/chat/widgets/bubble.dart';

class InterviewTabView extends HookConsumerWidget with ChatEvent {
  const InterviewTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return Column(
      children: [
        Consumer(
          builder: (context, ref, _) {
            final chatListAsync = ref.watch(chatListProvider);
            return Expanded(
              child: GestureDetector(
                onVerticalDragStart: (_) {
                  ref.read(chatFocusNodeProvider).unfocus();
                },
                onTap: () {
                  ref.read(chatFocusNodeProvider).unfocus();
                },
                child: chatListAsync.when(
                  data: (chatList) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        controller: ref.watch(chatScrollControllerProvider),
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 24, bottom: 20) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          final item = chatList[index];

                          return Bubble(
                            chat: item,
                            isLatestReceivedChatInEachSection: ref
                                .read(chatListProvider.notifier)
                                .isLastReceivedChatInEachQuestion(index: index),
                          );
                        },
                      ),
                    );
                  },
                  error: (e, _) => Center(
                    child: Text('채팅 내역을 불러오지 못했습니다[$e]'),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
        ),

        /// 하단 입력창
        const _BottomInputField(),
      ],
    );
  }
}

class _BottomInputField extends HookConsumerWidget with ChatEvent {
  const _BottomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = TextEditingController();

    return SafeArea(
      child: Container(
        color: AppColor.of.white,
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 240),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Stack(
          children: [
            TextField(
              focusNode: ref.watch(chatFocusNodeProvider),
              onChanged: (message) {
                ref.read(chatInputProvider.notifier).update(message);
              },
              controller: textEditingController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                fillColor: AppColor.of.background1,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  right: 42,
                  left: 16,
                  top: 18,
                ),
                hintText: '답변을 입력해 주세요',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Consumer(
                builder: (context, ref, _) {
                  return IconButton(
                    icon: SvgPicture.asset(
                      Assets.iconsSend,
                      colorFilter: ColorFilter.mode(
                        ref.watch(chatInputProvider).isNotEmpty
                            ? AppColor.of.blue2
                            : AppColor.of.gray3,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      onChatFieldSubmitted(
                        ref,
                        message: textEditingController.text,
                        textEditingController: textEditingController,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
