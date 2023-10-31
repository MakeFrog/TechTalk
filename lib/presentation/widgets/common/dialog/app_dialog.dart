import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

class AppDialog extends Dialog {
  const AppDialog({
    Key? key,
    this.isDividedBtnFormat = false,
    this.description,
    this.subTitle,
    this.onLeftBtnClicked,
    this.leftBtnText,
    required this.btnText,
    required this.onBtnClicked,
    required this.title,
  }) : super(key: key);

  factory AppDialog.singleBtn({
    required String title,
    required VoidCallback onBtnClicked,
    String? subTitle,
    String? description,
    String? btnContent,
  }) =>
      AppDialog(
        title: title,
        subTitle: subTitle,
        onBtnClicked: onBtnClicked,
        description: description,
        btnText: btnContent,
      );

  factory AppDialog.dividedBtn({
    required String title,
    String? description,
    String? subTitle,
    required String leftBtnContent,
    required String rightBtnContent,
    required VoidCallback onRightBtnClicked,
    required VoidCallback onLeftBtnClicked,
  }) =>
      AppDialog(
        isDividedBtnFormat: true,
        title: title,
        subTitle: subTitle,
        onBtnClicked: onRightBtnClicked,
        onLeftBtnClicked: onLeftBtnClicked,
        description: description,
        leftBtnText: leftBtnContent,
        btnText: rightBtnContent,
      );

  final bool isDividedBtnFormat;
  final String title;
  final String? description;
  final VoidCallback onBtnClicked;
  final VoidCallback? onLeftBtnClicked;
  final String? btnText;
  final String? leftBtnText;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints(minHeight: 120, maxWidth: 256),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(
            0xFFEFEFEF,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 본분
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 10),
                      child: Text(
                        title,
                        style: AppTextStyle.title3.copyWith(
                          color: AppColor.of.brand3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (subTitle != null) ...[
                    Text(
                      subTitle!,
                      style: AppTextStyle.alert1.copyWith(
                        color: AppColor.of.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const HeightBox(14),
                  ],
                  if (description != null) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          description!,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.alert2.copyWith(
                              color: const Color(0xFF606060), height: 1.3),
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
            // 하단 버튼

            // 두개의 버튼으로 나누어진 형식이라면 아래 위젯을 러틴
            if (isDividedBtnFormat)
              Container(
                height: 44,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFB3B3B3),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        onPressed: onLeftBtnClicked,
                        child: Center(
                          child: Text(
                            leftBtnText!,
                            style: AppTextStyle.title3
                                .copyWith(color: AppColor.of.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.5,
                      color: const Color(0xFFB3B3B3),
                    ),
                    Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        onPressed: onBtnClicked,
                        child: Center(
                          child: Text(
                            btnText ?? '확인',
                            style: AppTextStyle.title3
                                .copyWith(color: AppColor.of.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 하나의 버튼으로 구성되어 있는 다이어로그 라면 아래 위젯을 리턴
            if (!isDividedBtnFormat)
              MaterialButton(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                onPressed: onBtnClicked,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFB3B3B3),
                        width: 0.5,
                      ),
                    ),
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      btnText ?? '확인',
                      style: AppTextStyle.title3.copyWith(
                        color: AppColor.of.black,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
