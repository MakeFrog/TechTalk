import 'dart:async';
import 'dart:isolate';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/blog_repository.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/features/blog/repository/entity/company_set.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _remoteDataSource;
  final TechSetRepository _techSetRepository;

  BlogRepositoryImpl(this._remoteDataSource, this._techSetRepository);

  /// Isolate에서 실행될 이미지 프리캐시 작업
  static Future<void> _isolateImagePrecache(List<String> imageUrls) async {
    final client = HttpClient();
    try {
      await Future.wait(
        imageUrls.map((url) async {
          try {
            final uri = Uri.parse(url);
            final request = await client.getUrl(uri);
            final response = await request.close();
            await response.drain<void>(); // 데이터를 읽어서 버퍼에 저장
          } catch (e) {
            logger.e('이미지 다운로드 실패 (Isolate): $url - $e');
          }
        }),
      );
    } finally {
      client.close();
    }
  }

  /// 이미지 프리캐시 처리
  Future<void> _precacheImages(List<BlogMainModel> models) async {
    try {
      // ignore: avoid_function_literals_in_foreach_calls
      models.forEach((model) async {
        if (model.thumbnailUrl.isNotEmpty) {
          unawaited(precacheImage(
              NetworkImage(model.thumbnailUrl), await navigationContext));
        }
      });
    } catch (e) {
      logger.e('이미지 프리캐시 실패: $e');
    }
  }

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

      final result = await _remoteDataSource.getRandomPagedBlogContents(
        lastDocument: convertedLastDocument,
        limit: limit,
        orderByField: orderByField,
        queryConstraints: queryConstraints,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        random: random,
        randomKey: randomKey,
      );

      unawaited(_precacheImages(result.items));

      final skills = _techSetRepository.getSkills();
      final jobGroups = _techSetRepository.getJobs();

      final items = result.items.map((model) {
        final relatedSkills = skills
            .where((skill) => model.relatedSkillIds.contains(skill.id))
            .toSet();
        final relatedJobGroups = jobGroups
            .where((group) => model.relatedJobGroupIds.contains(group.id))
            .toSet();

        return model.toEntity(relatedSkills, relatedJobGroups);
      }).toList();

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

  @override
  Future<Result<List<CompanyInfoEntity>>> initCompanyList() async {
    try {
      final response = await _remoteDataSource.getCompanyList();
      final result =
          response.map((model) => CompanyInfoEntity.fromModel(model)).toList();
      CompanySet().addCompanies(result);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
