part of 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';

///
/// 이력서 관리에만 사용되는 BottomSheet
/// 파일 변경, 미리보기, 삭제에 사용됨
///
class ResumeManageBottomSheet<T extends dynamic> extends StatelessWidget {
  const ResumeManageBottomSheet({
    Key? key,
    required this.options,
    required this.onOptionTapped,
    required this.onCloseBtnTapped,
    required this.leadingText,
  }) : super(key: key);

  final List<String> options;
  final void Function(int index) onOptionTapped;
  final VoidCallback onCloseBtnTapped;
  final String leadingText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: context.pop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 12 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// 제목
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.of.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    leadingText,
                    style: AppTextStyle.alert2,
                  ),
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: AppColor.of.gray2,
              ),

              /// 선택 영역
              ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColor.of.gray2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  // 변경, 미리보기 삭제
                  return MaterialButton(
                    color: AppColor.of.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: options.length == index + 1
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : BorderRadius.zero,
                    ),
                    onPressed: () {
                      context.pop();
                      onOptionTapped(index);
                    },
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          options[index],
                          style: index == options.length - 1
                              ? AppTextStyle.title2.copyWith(
                                  color: Colors.red,
                                )
                              : AppTextStyle.title2,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Gap(8),

              // 닫기
              MaterialButton(
                color: AppColor.of.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: onCloseBtnTapped,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      context.tr(
                        LocaleKeys.common_close,
                      ),
                      style: AppTextStyle.title3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
