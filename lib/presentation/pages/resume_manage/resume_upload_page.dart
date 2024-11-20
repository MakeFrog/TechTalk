// import 'package:bounce_tapper/bounce_tapper.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:techtalk/app/style/index.dart';
// import 'package:techtalk/core/index.dart';
// import 'package:techtalk/presentation/pages/resume_manage/resume_event.dart';
// import 'package:techtalk/presentation/widgets/base/base_page.dart';
// import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

// class ResumeUploadPage extends BasePage with ResumeEvent {
//   const ResumeUploadPage({
//     super.key,
//   });

//   @override
//   Widget buildPage(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Gap(20),
//           Text(
//             '아직 이력서가 없어요\n이력서를 등록해 주세요',
//             style: AppTextStyle.headline1,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 12),
//             child: Text(
//               '윤수님의 이력서로 만든 예상 질문을 경험해 보세요!',
//               style: AppTextStyle.body1.copyWith(
//                 color: AppColor.of.gray4,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
//       const BackButtonAppBar();

//   @override
//   Widget? buildFloatingActionButton(WidgetRef ref) {
//     return const _NextButton();
//   }

//   @override
//   FloatingActionButtonLocation? get floatingActionButtonLocation =>
//       FloatingActionButtonLocation.centerDocked;
// }

// class _NextButton extends ConsumerWidget with ResumeEvent {
//   const _NextButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       height: 56,
//       child: BounceTapper(
//         onTap: () => uploadPortfolioFile(ref),
//         child: FilledButton(
//           onPressed: () {},
//           child: const Center(
//             child: Text('이력서 등록하기'),
//           ),
//         ),
//       ),
//     );
//   }
// }
