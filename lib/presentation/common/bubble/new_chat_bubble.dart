library flutter_chat_bubble;

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';

/** Created By Ximiya - 2023.04.18
 *  말풍성 UI
 *  [flutter_chat_bubble] 패키지를 별도로 커스텀
 *  불필요 코드를 걷어내고 해당 프로젝트에 최적화 시킴
 * */

class NewChatBubble extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double maxWidth;
  final ChatMessageType messageType;

  const NewChatBubble({
    super.key,
    this.margin,
    required this.child,
    required this.maxWidth,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignmentOnType,
      margin: margin ?? EdgeInsets.zero,
      child: PhysicalShape(
        clipper: clipperOnType,
        elevation: 2,
        color: bgColorOnType,
        shadowColor: Colors.grey.shade200,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          padding: paddingOnType,
          child: child,
        ),
      ),
    );
  }

  Color get bgColorOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return const Color(0xffE7E7ED);
      case ChatMessageType.replyToAnswer:
        return const Color(0xffE7E7ED);
      case ChatMessageType.answerQuestion:
        return AppColor.blue;
    }
  }

  CustomClipper<Path> get clipperOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return ChatBubbleClipper1(type: BubbleType.receiverBubble);
      case ChatMessageType.answerQuestion:
        return ChatBubbleClipper1(type: BubbleType.sendBubble);
      case ChatMessageType.replyToAnswer:
        return ChatBubbleClipper1(type: BubbleType.receiverBubble);
    }
  }

  Alignment get alignmentOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return Alignment.topLeft;
      case ChatMessageType.answerQuestion:
        return Alignment.topRight;
      case ChatMessageType.replyToAnswer:
        return Alignment.topLeft;
    }
  }

  EdgeInsets get paddingOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
      case ChatMessageType.answerQuestion:
        return const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20);
      case ChatMessageType.replyToAnswer:
        return const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
    }
  }
}
