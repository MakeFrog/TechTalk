// import 'package:bounce_tapper/bounce_tapper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:techtalk/app/style/index.dart';
// import 'package:techtalk/core/index.dart';
// import 'package:techtalk/presentation/pages/home/home_event.dart';
// import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

// class TestResumeInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
//   const TestResumeInterviewCard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return BounceTapper(
//       onTap: testSetAiResumeQuestionUseCase,
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//         decoration: BoxDecoration(
//           color: AppColor.of.brand1,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     '이력서 프롬프트 실험 버튼\n(Print 출력)',
//                     style: AppTextStyle.headline2.copyWith(
//                       color: AppColor.of.brand3,
//                     ),
//                   ),
//                 ),
//                 BounceTapper(
//                   highlightColor: Colors.transparent,
//                   onTap: () {
//                     /// 임시 로직
//                     // routeToChatPage(
//                     //   ref,
//                     //   type: InterviewType.resume,
//                     //   topics: [],
//                     // );
//                   },
//                   child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
//                 ),
//               ],
//             ),
//             if (!(user(ref)?.hasPracticalInterviewRecord ?? false))
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 12, right: 24),
//                 child: Text(
//                   '이력서를 첨부하여 면접을 시작해보세요!',
//                   style: AppTextStyle.body1.copyWith(
//                     color: AppColor.of.gray3,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
