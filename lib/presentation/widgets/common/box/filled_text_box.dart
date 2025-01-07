import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/state/keep_alive_view.dart';

class FilledTextBox extends StatelessWidget {
  const FilledTextBox({super.key, required this.contents});

  final List<String> contents;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        16,
      ),
      child: ColoredBox(
        color: AppColor.of.background1,
        child: KeepAliveView(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 17.19,
            ),
            shrinkWrap: true,
            itemCount: contents.length,
            separatorBuilder: (_, __) => Divider(
              color: AppColor.of.gray1,
              height: 17,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final content = contents[index];
              return Text(
                content,
                style: AppTextStyle.body2.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
