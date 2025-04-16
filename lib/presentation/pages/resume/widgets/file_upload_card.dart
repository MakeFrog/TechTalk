import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';

///
/// 이력서 파일을 새로 업로드할 때
///
class FileUploadCard extends ConsumerWidget with ResumeEvent {
  const FileUploadCard({Key? key, required this.type}) : super(key: key);

  final DocumentType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(12),
        Text(
          type == DocumentType.resume ? '이력서' : '포트폴리오',
          style: AppTextStyle.headline2,
        ),
        const Gap(8),
        BounceTapper(
          highlightColor: Colors.transparent,
          onTap: () => registDocumentState(ref, type),
          child: DottedBorder(
            color: AppColor.of.gray2,
            dashPattern: const [6, 1],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: Container(
              width: double.infinity,
              height: 163,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: 112,
                    child: SvgPicture.asset(
                      Assets.iconsRoundBlueCircle,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    "파일 업로드",
                    style:
                        AppTextStyle.body2.copyWith(color: AppColor.of.gray3),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12),
      ],
    );
  }
}