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

class StreamChatBubble extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry? margin;
  final ChatMessageType messageType;

  const StreamChatBubble({
    super.key,
    this.margin,
    required this.messageType,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar_1.png"),
        ),
        Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalShape(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            elevation: 2,
            color: const Color(0xffE7E7ED),
            shadowColor: Colors.grey.shade200,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.to.screenWidth * 0.8,
              ),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 10),
              child: Text(
                message,
                style: const TextStyle(color: AppColor.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
