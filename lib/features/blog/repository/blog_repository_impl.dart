import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/blog_repository.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _remoteDataSource;
  final TechSetRepository _techSetRepository;

  BlogRepositoryImpl(this._remoteDataSource, this._techSetRepository);

  @override
  Future<Result<FirebasePaginatedResult<BlogShellEntity, BlogMainModel>>>
      getRandomPagedBlogContents({
    required DocumentSnapshot<BlogShellEntity>? lastDocument,
    required int limit,
    required String orderByField,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      DocumentSnapshot<BlogMainModel>? convertedLastDocument;
      if (lastDocument != null) {
        final snapshot = await lastDocument.reference
            .withConverter(
              fromFirestore: BlogMainModel.fromFirestore,
              toFirestore: (value, options) => value.toFirestore(),
            )
            .get();
        convertedLastDocument = snapshot;
      }

      // Remote DataSource에서 페이징된 데이터 가져오기
      final result = await _remoteDataSource.getRandomPagedBlogContents(
        lastDocument: convertedLastDocument,
        limit: limit,
        orderByField: orderByField,
        queryConstraints: queryConstraints,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        random: random,
        randomKey: randomKey,
      );

      // 스킬과 직군 정보 가져오기
      final skills = _techSetRepository.getSkills();
      final jobGroups = _techSetRepository.getJobs();

      // Model을 Entity로 변환
      final items = result.items.map((model) {
        final relatedSkills = skills
            .where((skill) => model.relatedSkillIds.contains(skill.id))
            .toSet();
        final relatedJobGroups = jobGroups
            .where((group) => model.relatedJobGroupIds.contains(group.id))
            .toSet();

        return model.toEntity(relatedSkills, relatedJobGroups);
      }).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult =
          FirebasePaginatedResult<BlogShellEntity, BlogMainModel>(
        items: items,
        lastDocument: result.lastDocument,
        hasMore: result.hasMore,
        hasReversedQueryCallProceeded: result.hasReversedQueryCallProceeded,
      );

      return Result.success(paginatedResult);
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
