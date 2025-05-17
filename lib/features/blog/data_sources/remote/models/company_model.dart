import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/blog/repository/enum/blog_platform_type.enum.dart';

part 'company_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CompanyModel {
  CompanyModel({
    this.id = '',
    this.name = '',
    this.feedUrl = '',
    this.logoUrl = '',
    this.platform = '',
  });

  final String id;
  final String name;
  final String feedUrl;
  final String logoUrl;
  final String platform;

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory CompanyModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    try {
      final data = snapshot.data();
      if (data == null) throw Exception('Document data is null');

      return CompanyModel(
        id: data['id'] as String? ?? snapshot.id,
        name: data['name'] as String? ?? '',
        feedUrl: data['feed_url'] as String? ?? '',
        logoUrl: data['logo_url'] as String? ?? '',
        platform: data['platform'] as String? ?? 'unknown',
      );
    } catch (e) {
      logger.e('Company 데이터 변환 실패 (${snapshot.id}): $e');
      rethrow;
    }
  }

  /// JSON에서 모델로 변환
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    try {
      return CompanyModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '알 수 없는 회사',
        feedUrl: json['feed_url'] as String? ?? '',
        logoUrl: json['logo_url'] as String? ?? '',
        platform: json['platform'] as String? ?? 'unknown',
      );
    } catch (e) {
      logger.e('Company JSON 변환 실패: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toFirestore() => toJson();

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  CompanyModel copyWith({
    String? id,
    String? name,
    String? feedUrl,
    String? logoUrl,
    String? platform,
    DateTime? createdAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      feedUrl: feedUrl ?? this.feedUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      platform: platform ?? this.platform,
    );
  }
}
