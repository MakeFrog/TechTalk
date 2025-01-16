import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/provider/youtube_link_submit_state.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/youtube_link_submit_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/input/techtalk_text_field.dart';

class YoutubeLinkSubmitPage extends BasePage
    with YoutubeLinkSubmitState, YoutubeLinkSubmitEvent {
  const YoutubeLinkSubmitPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            '학습을 원하는\n영상의 링크를 알려주세요',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '영상 요약과 질문을 생성해 드릴게요',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Gap(56),
          Form(
            key: formKey(ref),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TechtalkTextField(
              controller: textEditingController(ref),
              validator: urlInputValidator,
              hintText: 'https://youtubue/blahblah',
              inputDecoration: InputDecoration(
                errorStyle: AppTextStyle.alert2.copyWith(),
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            child: Container(
              margin:
                  EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
              width: double.infinity,
              child: HookBuilder(
                builder: (context) {
                  final isInputFilled =
                      useListenableSelector(textEditingController(ref), () {
                    return urlInputValidator(textEditingController(ref).text);
                  });

                  return FilledButton(
                    onPressed: isInputFilled == null
                        ? () {
                            onConfirmBtnTapped(ref);
                          }
                        : null,
                    child: const Text(
                      '다음',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
