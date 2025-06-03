import 'package:hive/hive.dart';

part 'portfolio_box.g.dart';

@HiveType(typeId: 6)
class PortfolioBox extends HiveObject {
  @HiveField(0, defaultValue: null)
  final String? portfolioPath;

  @HiveField(1, defaultValue: null)
  final String? portfolioTitle;

  @HiveField(2, defaultValue: null)
  final String? portfolioUploadAt;

  @HiveField(3, defaultValue: null)
  final String? portfolioExtractedText;

  PortfolioBox({
    this.portfolioPath,
    this.portfolioTitle,
    this.portfolioUploadAt,
    this.portfolioExtractedText,
  });

  PortfolioBox copyWith({
    String? portfolioPath,
    String? portfolioTitle,
    String? portfolioUploadAt,
    String? portfolioExtractedText,
  }) {
    return PortfolioBox(
      portfolioPath: portfolioPath ?? this.portfolioPath,
      portfolioTitle: portfolioTitle ?? this.portfolioTitle,
      portfolioUploadAt: portfolioUploadAt ?? this.portfolioUploadAt,
      portfolioExtractedText: portfolioExtractedText ?? this.portfolioExtractedText,
    );
  }
}
