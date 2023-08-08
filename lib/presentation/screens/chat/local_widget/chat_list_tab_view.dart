import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/resources/ui_config/app_insets.dart';
import 'package:techtalk/app/resources/ui_config/app_space_config.dart';
import 'package:techtalk/app/resources/ui_config/color_config.dart';
import 'package:techtalk/app/resources/ui_config/size_config.dart';
import 'package:techtalk/domain/enum/chat_message_type_enum.dart';
import 'package:techtalk/domain/model/chat/chat.dart';
import 'package:techtalk/presentation/base/base_view.dart';
import 'package:techtalk/presentation/common/bubble/sender_chat_bubble.dart';
import 'package:techtalk/presentation/common/bubble/stream_base_chat_bubble.dart';
import 'package:techtalk/presentation/screens/chat/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatListTabView extends BaseView<ChatViewModel> {
  const ChatListTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Selector<ChatViewModel, List<Chat>>(
            selector: (BuildContext context, ChatViewModel vm) {
              return vm.chatList;
            },
            builder: (context, chatList, child) {
              return GestureDetector(
                onTap: vm(context).onFocusKeyboard,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    controller: vm(context).firstTabScrollController,
                    padding: AppInset.top12 +
                        AppInset.horizontal12 +
                        AppInset.bottom16,
                    itemCount: chatList.length,
                    itemBuilder: (_, index) {
                      if (chatList[index].type.isReceiverType) {
                        return StreamBuilder<String>(
                          stream: chatList[index].message,
                          builder: (context, snapshot) {
                            return StreamChatBubble(
                              messageType: chatList[index].type,
                              message: snapshot.data ?? "...",
                            );
                          },
                        );
                      } else {
                        return SenderChatBubble(
                          index: index,
                          messageType: chatList[index].type,
                          message: chatList[index].message.value,
                          correctness: chatList[index].correctness,
                          sendTime: chatList[index].sendTime!,
                        );
                      }
                    },
                    separatorBuilder: (_, __) => AppSpace.size14,
                  ),
                ),
              );
            },
          ),
        ),
        const _StackedInputField(),
      ],
    );
  }
}

/// 하단 고정 텍스트 입력창
class _StackedInputField extends BaseView<ChatViewModel> {
  const _StackedInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      width: SizeConfig.to.screenWidth,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA),
          ),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            focusNode: vm(context).focusNode,
            onChanged: vm(context).onFieldChanged,
            controller: vm(context).textEditingController,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                right: 42,
                left: 16,
                top: 18,
              ),
              // ⚠️ suffix icon의 inkwell 효과를 고려하고 싶다면, TextField의 Color를 trasnparent로 설정해야됨
              hintText: '답변을 입력하세요',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          // suffix 전송 버튼
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/send.svg",
                colorFilter: ColorFilter.mode(
                  vmS(
                    context,
                    (value) => value.isTextFieldActivated
                        ? AppColor.blue
                        : const Color(0xFFBDBDC2),
                  ),
                  BlendMode.srcIn,
                ),
              ),
              onPressed: vm(context).onFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
