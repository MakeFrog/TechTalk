import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_state.dart';
import 'package:techtalk/presentation/pages/resume/widgets/file_upload_card.dart';

///
/// 이력서 카드 / 포트폴리오 카드 위젯
///
class ResumeCard extends ConsumerWidget
    with ResumeManageEvent, ResumeManageState {
  final DocumentType type;
  final DocumentBaseEntity doc;

  const ResumeCard._({
    Key? key,
    required this.type,
    required this.doc,
  }) : super(key: key);

  /// 이력서 Card
  factory ResumeCard.resume({required ResumeEntity? resume}) {
    return ResumeCard._(
      // 고정값
      type: DocumentType.resume,
      doc: resume ?? ResumeEntity(),
    );
  }

  /// 포트폴리오 Card
  factory ResumeCard.portfolio({required PortfolioEntity? portfolio}) {
    return ResumeCard._(
      // 고정값
      type: DocumentType.portfolio,
      doc: portfolio ?? PortfolioEntity(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 만약 파일 경로(path)가 비어있다면 => 파일이 없으므로, FileUploadCard 반환
    if (doc.path == null) {
      return FileUploadCard(type: type);
    }

    // 파일이 존재한다면 => 기존 UI
    final title = doc.title;
    final date = doc.uploadAt;

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
          onTap: () => onRegisteredFileBtnTapped(ref, type),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.of.gray2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.headline2,
                ),
                const Gap(36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date ?? '',
                      style:
                          AppTextStyle.body2.copyWith(color: AppColor.of.gray4),
                    ),
                    SvgPicture.asset(Assets.iconsMoreNoCircle),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(12),
      ],
    );
  }
}
