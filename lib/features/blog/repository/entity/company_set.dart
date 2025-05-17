import 'package:techtalk/features/blog/data_sources/remote/models/company_model.dart';
import 'package:techtalk/features/blog/repository/enum/blog_platform_type.enum.dart';

final class CompanySet {
  static final CompanySet _instance = CompanySet._internal();

  factory CompanySet() {
    return _instance;
  }

  CompanySet._internal();

  List<CompanyInfoEntity> _companies = [];

  void initialize(List<CompanyInfoEntity> companies) {
    _companies = companies;
  }

  void addCompany(CompanyInfoEntity company) {
    if (!_companies.any((element) => element.id == company.id)) {
      _companies.add(company);
    }
  }

  void addCompanies(List<CompanyInfoEntity> companies) {
    for (final company in companies) {
      addCompany(company);
    }
  }

  CompanyInfoEntity? getCompany(String id) {
    try {
      return _companies.firstWhere((company) => company.id == id);
    } catch (_) {
      return null;
    }
  }

  List<CompanyInfoEntity> getAllCompanies() => List.from(_companies);

  void clear() => _companies.clear();

  bool get isEmpty => _companies.isEmpty;
  bool get isNotEmpty => _companies.isNotEmpty;
  int get length => _companies.length;
}

class CompanyInfoEntity {
  final String id;
  final String name;
  final String logoUrl;
  final BlogPlatformType platform;

  const CompanyInfoEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.platform,
  });

  factory CompanyInfoEntity.fromModel(CompanyModel model) {
    return CompanyInfoEntity(
      id: model.id,
      name: model.name,
      logoUrl: model.logoUrl,
      platform: BlogPlatformType.getById(model.platform),
    );
  }
}
