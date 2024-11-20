import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/pages/youtube/youtube_contents_main_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class ContentsMainPage extends BasePage with YoutubeContentsMainEvent {
  const ContentsMainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    // TODO: 컨텐츠 Overview 리스트로 띄워주는 로직 및 UI 구현
    return Scaffold(
      body: GestureDetector(
        onTap: () => routeToChatPage(
          context,
          overview: YoutubeContentsOverviewEntity(
            id: 'fB3MB8TXNXM',
            thumbnailImgUrl: 'https://i.ytimg.com/vi/fB3MB8TXNXM/maxresdefault.jpg',
            contentsTitle: 'REST API - 이거 하나로 끝남',
            author: ContentsAuthorEntity(id: 'yalco-coding', name: '얄팍한 코딩사전'),
            relatedJobs: {JobGroup.ANDROID_DEVELOPER},
            relatedSkills: {SkillEntity(id: 'android', name: 'Android')},
            videoDuration: Duration(minutes: 13, seconds: 1),
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
