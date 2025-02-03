import 'package:hive/hive.dart';

part 'portfolio_box.g.dart';

@HiveType(typeId: 5)
class PortfolioBox extends HiveObject {
  @HiveField(0, defaultValue: null)
  final String? portfolioPath;

  @HiveField(1, defaultValue: null)
  final String? portfolioTitle;

  @HiveField(2, defaultValue: null)
  final String? portfolioUploadAt;

  PortfolioBox({
    this.portfolioPath,
    this.portfolioTitle,
    this.portfolioUploadAt,
  });

  PortfolioBox copyWith({
    String? portfolioPath,
    String? portfolioTitle,
    String? portfolioUploadAt,
  }) {
    return PortfolioBox(
      portfolioPath: portfolioPath ?? this.portfolioPath,
      portfolioTitle: portfolioTitle ?? this.portfolioTitle,
      portfolioUploadAt: portfolioUploadAt ?? this.portfolioUploadAt,
    );
  }
}
