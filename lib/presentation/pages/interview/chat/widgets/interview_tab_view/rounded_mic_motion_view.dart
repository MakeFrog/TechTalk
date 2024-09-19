import 'package:flutter/material.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';

class RoundedMicMotionView extends StatelessWidget with ChatEvent, ChatState {
  const RoundedMicMotionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return GestureDetector(
    //   onTap: () => onMainBtnTapped(
    //     speechToText,
    //     speechController,
    //     ref,
    //     textEditingController,
    //   ),
    //   child: Container(
    //     width: 112,
    //     height: 112,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       color: AppColor.of.blue1,
    //     ),
    //     child: Center(
    //       child: CircleAvatar(
    //         radius: 44,
    //         backgroundColor: speechController.state.value ==
    //             SpeechUiState.submitMessage
    //             ? AppColor.of.brand3
    //             : Colors.white,
    //         child: Center(
    //           child: SvgPicture.asset(
    //             _getMainBtnIcon(speechController.state.value),
    //             width: 44,
    //             colorFilter: speechController.state.value ==
    //                 SpeechUiState.submitMessage
    //                 ? const ColorFilter.mode(
    //               Colors.white,
    //               BlendMode.srcIn,
    //             )
    //                 : ColorFilter.mode(
    //               AppColor.of.brand3,
    //               BlendMode.srcIn,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
