import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/util/app_format_handler.dart';
import 'package:techtalk/app/util/app_formatter.dart';
import 'package:techtalk/features/blog/repository/entity/company_set.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/chip/outlined_chip.dart';
import 'package:techtalk/presentation/widgets/common/constant/content_filter_category.dart';

///
/// [BlogMainPage] 등 블로그 항목의 Shell
/// 정보를 보여주는 리스트 아이템 뷰
///
class BlogContentItemView extends StatelessWidget {
  const BlogContentItemView({
    super.key,
    required this.item,
    this.isLoaded = true,
  });

  final BlogShellEntity item;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BounceTapper(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.headline2,
              ),
              if (item.description.isNotEmpty) ...[
                const Gap(4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.body3.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ],
              const Gap(6),

              /* THUMBNAIL */
              if (isLoaded && item.thumbnailUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 4,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 16 / 8.5,
                      child: Container(
                        color: const Color(0xFFE2E2E2),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: item.thumbnailUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 300),
                          fadeInCurve: Curves.easeInOut,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFE2E2E2),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColor.of.gray4,
                                  size: 32,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              else
                const SkeletonBox(),

              /* TECH SET LIST */ // --> 8 top
              HookBuilder(
                builder: (context) {
                  List<ContentFilterCategory> categories = useMemoized(
                    () => [
                      ...item.relatedJobGroups
                          .map(ContentFilterCategory.fromJob),
                      ...item.relatedSkills.map(ContentFilterCategory.fromSkill)
                    ]..shuffle(),
                  );

                  if (categories.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double remainingWidth =
                              constraints.maxWidth; // 부모 컨테이너의 너비
                          const double spacing = 4; // Chip 간의 간격
                          const double indicatorPadding =
                              20; // +n 인디케이터 내부 여백 포함

                          List<Widget> visibleChips = [];
                          int hiddenCount = 0;

                          // 숨겨진 개수 인디케이터의 초기값 설정
                          double indicatorWidth = 0;
                          if (categories.isNotEmpty) {
                            final TextPainter indicatorTextPainter =
                                TextPainter(
                              text: TextSpan(
                                text: '+999', // 초기 예상 텍스트로 최대 길이를 잡음
                                style: AppTextStyle.alert1,
                              ),
                              textDirection: TextDirection.ltr,
                            )..layout();

                            indicatorWidth =
                                indicatorTextPainter.width + indicatorPadding;
                          }

                          for (final category in categories) {
                            final TextPainter textPainter = TextPainter(
                              text: TextSpan(
                                text: category.name,
                                style: AppTextStyle.alert1,
                              ),
                              textDirection: TextDirection.ltr,
                            )..layout();

                            final double chipWidth =
                                textPainter.width + 16; // Chip 내부 여백 포함

                            // 인디케이터를 고려한 남은 공간 확인
                            if (remainingWidth >=
                                chipWidth + spacing + indicatorWidth) {
                              visibleChips.add(
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: spacing,
                                  ),
                                  child: OutlinedChip(
                                    label: category.name,
                                  ),
                                ),
                              );
                              remainingWidth -= chipWidth + spacing;
                            } else {
                              hiddenCount =
                                  categories.length - visibleChips.length;
                              break;
                            }
                          }

                          // 숨겨진 개수 인디케이터 추가
                          if (hiddenCount > 0) {
                            visibleChips.add(
                              Container(
                                height: 25,
                                width: indicatorWidth - 10,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '+$hiddenCount',
                                  style: AppTextStyle.alert1.copyWith(
                                    color: AppColor.of.gray3,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Wrap(
                            children: visibleChips,
                          );
                        },
                      ),
                    );
                  } else {
                    return const EmptyBox();
                  }
                },
              ),

              /* AUTHRO (COMPANY INFO) */
              Divider(
                height: 28,
                thickness: 0.7,
                color: AppColor.of.gray1,
              ),
              if (item.isCompanyBlog)
                HookBuilder(
                  builder: (context) {
                    final company =
                        useMemoized(() => CompanySet().getCompany(item.blogId));
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: company?.logoUrl ?? '',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColor.of.gray4,
                                size: 32,
                              );
                            },
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              company?.name ?? '회사명 없음',
                              style: AppTextStyle.title3.copyWith(),
                            ),
                            if (item.author.isNotEmpty)
                              Text(
                                item.author,
                                style: AppTextStyle.alert2.copyWith(
                                  color: AppColor.of.gray3,
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          AppFormatter.formatDateToYYYYMMDD(
                            item.publishDate,
                          ),
                          style: AppTextStyle.alert2.copyWith(
                            color: AppColor.of.gray3,
                          ),
                        ),
                      ],
                    );
                  },
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.author.isEmpty ? '작성자 없음' : item.author,
                      style: AppTextStyle.title3.copyWith(),
                    ),
                    Text(
                      AppFormatter.formatDateToYYYYMMDD(
                        item.publishDate,
                      ),
                      style: AppTextStyle.alert2.copyWith(
                        color: AppColor.of.gray3,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
