import 'package:techtalk/features/youtube/index.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class ChannelDetailEntity extends ChannelEntity {
  ChannelDetailEntity({
    required super.id,
    required super.name,
    required super.logoUrl,
    required this.bannerUrl,
    required this.subscribersCount,
  });

  /// 배너 이미지
  final String bannerUrl;

  /// 구독자 수
  final int? subscribersCount;

  factory ChannelDetailEntity.fromExplore(Channel explore) =>
      ChannelDetailEntity(
        id: explore.id.value,
        name: explore.title,
        logoUrl: explore.logoUrl,
        bannerUrl: explore.bannerUrl,
        subscribersCount: explore.subscribersCount,
      );

  ChannelDetailEntity copyWith({
    String? id,
    String? name,
    String? logoUrl,
    String? bannerUrl,
    int? subscribersCount,
  }) {
    return ChannelDetailEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      subscribersCount: subscribersCount ?? this.subscribersCount,
    );
  }
}
