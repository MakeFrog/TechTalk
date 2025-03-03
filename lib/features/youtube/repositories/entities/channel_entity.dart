import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';

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

  ///
  /// 호출에 실패했을 경우
  ///
  factory ChannelEntity.undefined() =>
      ChannelEntity(id: 'undefined', name: '알 수 없는 채널');

  ChannelModel toModel() => ChannelModel(
        id: id,
        name: name,
        logoUrl: logoUrl,
      );
}
