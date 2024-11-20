import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_detail_ref.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_overview_ref.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:techtalk/presentation/pages/youtube/youtube_contents_detail_event.dart';
import 'package:techtalk/presentation/pages/youtube/youtube_contents_detail_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/box/async_skeleton_widget_builder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 유튜브 컨텐츠 상세 페이지
class YoutubeContentsDetailPage extends BasePage with YoutubeContentsDetailEvent, YoutubeContentsDetailState {
  const YoutubeContentsDetailPage({super.key, required this.overview});

  final ContentsOverviewEntity overview;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AsyncSkeletonWidgetBuilder(
          asyncValue: youtubeVideoDataAsync(ref, overview.id),
          skeletonBuilder: (p0) => SizedBox(
            height: 210,
            width: double.infinity,
            child: Image.network(
              overview.thumbnailImgUrl,
              fit: BoxFit.cover,
            ),
          ),
          dataBuilder: (context, data) => SizedBox(
            height: 210,
            width: double.infinity,
            // TODO: 이미지 캐싱 기능 구현
            child: Image.network(
              data.thumnailSet.highResUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Wrap(
            runSpacing: 5,
            children: [
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.id),
                skeletonBuilder: (p0) => Text(
                  overview.contentsTitle,
                  style: AppTextStyle.headline3,
                ),
                dataBuilder: (context, data) => Text(
                  data.title,
                  style: AppTextStyle.headline3,
                ),
              ),
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.id),
                skeletonBuilder: (_) => const SkeletonBox(
                  height: 20,
                ),
                dataBuilder: (context, data) => Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(data.likeCountStr),
                      ],
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text('조회수 ${data.viewCountStr}'),
                  ],
                ),
              ),
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.id),
                skeletonBuilder: (p0) => const SkeletonBox(
                  height: 20,
                ),
                dataBuilder: (context, data) => Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data.channelInfo.logoUrl),
                      radius: 15,
                    ),
                    Text(
                      data.channelInfo.title,
                    ),
                    Text(
                      (data.channelInfo.subscribersCount ?? '').toString(),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: overview.relatedSkills
                    .map(
                      (skill) => Chip(label: Text(skill.name)),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    final contentsDetail = YoutubeContentsDetailEntity(
      id: 'fB3MB8TXNXM',
      title: 'REST API - 이거 하나로 끝남',
      authorId: 'coding',
      relatedSkills: {SkillEntity(id: 'android', name: 'Android')},
      relatedJobs: {JobGroup.ANDROID_DEVELOPER},
      contentsLanguage: {ContentsLanguage.korean},
      relatedQna: [
        QnaEntity(
          question: 'API란 무엇이며, 소프트웨어 간의 통신에서 어떤 역할을 하나요?',
          id: 'qna1',
          answers: [],
          questionInstruction: 'API가 소프트웨어들 간의 상호작용을 어떻게 돕는지 설명해보세요.',
        ),
        QnaEntity(
          question: 'REST AP I에서 클라이언트와 서버의 역할은 무엇이며, 이 둘 간의 요청과 응답은 어떻게 이루어지나요?',
          id: 'qna2',
          answers: [],
          questionInstruction: '클라이언트가 서버에 요청을 보내는 방식과 서버가 응답하는 방식에 대해 설명해보세요.',
        ),
      ],
      summary: SummaryEntity(
        mainTheme: [
          'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
        ],
        summaryNotes: [
          ParagraphEntity(
            title: '💻 API의 역할과 기능',
            contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
            timestamp: Duration(seconds: 1),
          ),
          ParagraphEntity(
            title: '🖥️ 윈도우 API와 GUI의 기본 개념',
            contents:
                '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
            timestamp: Duration(minutes: 9, seconds: 46),
          ),
        ],
      ),
    );

    final overview = YoutubeContentsOverviewEntity(
      id: 'fB3MB8TXNXM',
      thumbnailImgUrl: 'https://i.ytimg.com/vi/fB3MB8TXNXM/maxresdefault.jpg',
      contentsTitle: 'REST API - 이거 하나로 끝남',
      author: ContentsAuthorEntity(id: 'yalco-coding', name: '얄팍한 코딩사전'),
      relatedJobs: {JobGroup.ANDROID_DEVELOPER},
      relatedSkills: {SkillEntity(id: 'android', name: 'Android')},
      videoDuration: Duration(minutes: 13, seconds: 1),
    );
    return FloatingActionButton(onPressed: () {
      addYoutubeContentsDetail(contentsDetail.id, contentsDetail.toModel());
      addYoutubeContentsOverview(contentsDetail.id, overview.toModel());
    });
  }

  @override
  bool get canPop => false;

  @override
  Color? get screenBackgroundColor => AppColor.of.white;

  @override
  Color? get unSafeAreaColor => AppColor.of.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => AppBar(
        leading: const AppBackButton(),
        titleSpacing: 0,
      );
}
