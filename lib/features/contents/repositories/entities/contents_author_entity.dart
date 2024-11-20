import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';

/// 컨텐츠 저자 정보 인터페이스
class ContentsAuthorEntity {
  /// 저자 id
  final String id;

  /// 저자 이름/닉네임
  final String name;

  /// 저자의 프로필 이미지 url
  final String? profileImgUrl;

  /// 저자의 메인 홈페이지 url
  final String? homePageUrl;

  ContentsAuthorEntity({
    required this.id,
    required this.name,
    this.profileImgUrl,
    this.homePageUrl,
  });

  ContentsAuthorModel toModel() => ContentsAuthorModel(
        id: id,
        name: name,
        profileImgUrl: profileImgUrl,
        homePageUrl: homePageUrl,
      );
}
