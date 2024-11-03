import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/pages/contents/contents_main_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class ContentsMainPage extends BasePage with ContentsMainEvent {
  const ContentsMainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    // TODO: 컨텐츠 Overview 리스트로 띄워주는 로직 및 UI 구현
    return Scaffold(
      body: GestureDetector(
        onTap: () => routeToChatPage(
          context,
          overview: VideoContentsOverviewEntity(
            id: 'zI1NzcV4Ef0',
            contentsId: 'zI1NzcV4Ef0',
            thumbnailImgUrl:
                'https://images.wondershare.kr/filmora/images/2021-images/seo/make-youtu-Thumbnail-use-filmora3.jpg',
            contentsTitle: '[배고파_마카오_EP.04] 밥에 감자튀김? 이런 건 나도 처음 보는데...?',
            author: ContentsAuthorEntity(id: 'id', name: '백종원'),
            relatedJobs: {JobGroup.ANDROID_DEVELOPER},
            relatedSkills: {SkillEntity(id: 'android', name: 'Android')},
            videoDuration: Duration(minutes: 20),
          ),
        ),
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.lightGreen,
            child: Text('콘텐츠 디테일 페이지로 이동'),
          ),
        ),
      ),
    );
  }
}
