library flutter_chat_bubble;

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/app/resources/uiConfig/size_config.dart';
import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';

/** Created By Ximiya - 2023.04.18
 *  말풍성 UI
 *  [flutter_chat_bubble] 패키지를 별도로 커스텀
 *  불필요 코드를 걷어내고 해당 프로젝트에 최적화 시킴
 * */

class NewChatBubble extends StatelessWidget {
  final Widget child;
  final String message;
  final EdgeInsetsGeometry? margin;
  final ChatMessageType messageType;

  const NewChatBubble({
    super.key,
    this.margin,
    required this.child,
    required this.messageType,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: alignmentOnType,
      children: [
        if (ChatMessageType.answerQuestion != messageType)
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar_1.png"),
          ),
        Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalShape(
            clipper: clipperOnType,
            elevation: 2,
            color: bgColorOnType,
            shadowColor: Colors.grey.shade200,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.to.screenWidth * 0.8,
              ),
              padding: paddingOnType,
              child: Text(
                message,
                style: TextStyle(color: textColorOnType),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color get textColorOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return AppColor.black;

      case ChatMessageType.replyToAnswer:
        return AppColor.black;

      case ChatMessageType.answerQuestion:
        return AppColor.white;
    }
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

  MainAxisAlignment get alignmentOnType {
    switch (messageType) {
      case ChatMessageType.alertMessage:
        return MainAxisAlignment.start;
      case ChatMessageType.replyToAnswer:
        return MainAxisAlignment.start;
      case ChatMessageType.answerQuestion:
        return MainAxisAlignment.end;
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
