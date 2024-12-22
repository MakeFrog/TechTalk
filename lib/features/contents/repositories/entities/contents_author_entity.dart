import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';

///
/// 유튜브 채널 정보
///
class ChannelEntity {
  /// 채널 id
  final String id;

  /// 채널명
  final String name;

  /// 채널의 로고 이미지
  final String? logoUrl;

  /// 채널 url
  String get url => 'https://www.youtube.com/channel/$id';

  ChannelEntity({
    required this.id,
    required this.name,
    this.logoUrl,
  });

  ChannelModel toModel() => ChannelModel(
        id: id,
        name: name,
        logoUrl: logoUrl,
      );
}
