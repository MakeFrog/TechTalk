library flutter_chat_bubble;

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/resources/ui_config/color_config.dart';
import 'package:techtalk/app/resources/ui_config/size_config.dart';
import 'package:techtalk/domain/enum/chat_message_type_enum.dart';
import 'package:techtalk/domain/model/chat/Correctness.dart';
import 'package:techtalk/presentation/screens/chat/chat_view_model.dart';
import 'package:techtalk/utilities/formatter.dart';
import 'package:provider/provider.dart';

/** Created By Ximiya - 2023.04.18
 *  말풍성 UI
 *  [flutter_chat_bubble] 패키지를 별도로 커스텀
 *  불필요 코드를 걷어내고 해당 프로젝트에 최적화 시킴
 * */

class SenderChatBubble extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry? margin;
  final ChatMessageType messageType;
  final Correctness correctness;
  final DateTime sendTime;
  final int index;

  const SenderChatBubble({
    super.key,
    this.margin,
    required this.correctness,
    required this.messageType,
    required this.message,
    required this.index,
    required this.sendTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalShape(
            clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
            elevation: 2,
            color: AppColor.blue,
            shadowColor: Colors.grey.shade200,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.to.screenWidth * 0.8,
              ),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: AppColor.white),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          Formatter.formatDateTime(sendTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Selector<ChatViewModel, Correctness>(
                          selector: (context, vm) =>
                              vm.chatList[index].correctness,
                          builder: (context, result, child) {
                            switch (result) {
                              case Correctness.correct:
                                return SvgPicture.asset(
                                  "assets/icons/correct.svg",
                                  height: 10,
                                  width: 10,
                                );
                              case Correctness.incorrect:
                                return SvgPicture.asset(
                                  "assets/icons/incorrect.svg",
                                  height: 10,
                                  width: 10,
                                );
                              case Correctness.checking:
                                return Column(
                                  children: const [
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 0.2,
                                      ),
                                    ),
                                  ],
                                );
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
