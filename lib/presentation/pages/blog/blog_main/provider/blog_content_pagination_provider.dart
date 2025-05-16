import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/features/blog/use_case/get_blog_contents_use_case.dart';
import 'package:techtalk/presentation/widgets/common/constant/content_filter_category.dart';

part 'blog_content_pagination_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<PagingController<DocumentSnapshot<BlogMainModel>?, BlogShellEntity>>
    blogContentPagination(
  BlogContentPaginationRef ref, {
  required ContentFilterCategory category,
}) {
  print('Blog Pagination Provider Created: ${category.id}'); // 디버그 로그

  final pagingController =
      PagingController<DocumentSnapshot<BlogMainModel>?, BlogShellEntity>(
    firstPageKey: null,
  );

  bool hasReversedQueryCallProceeded = false;

  final random = Random();
  final randomValue = random.nextDouble();
  final randomKey = (random.nextInt(5) + 1).toString();

  // 페이지 요청 리스너 추가
  pagingController.addPageRequestListener((pageKey) async {
    print('Blog Page Request: ${category.id}, pageKey: $pageKey'); // 디버그 로그

    final params = GetBlogContentsOverviewsListParams(
      lastDocument: pageKey,
      limit: 15,
      orderByField: 'created_at',
      queryConstraints: !category.type.isAll
          ? [
              // '전체' 카테고리가 아닐 경우 '필터링' 항목 설정
              ArrayContainsAnyConstraint(
                fieldPath: category.type.documentFieldName,
                values: [category.id],
              ),
            ]
          : null,
      isHalfOfRandomCalled: hasReversedQueryCallProceeded,
      random: randomValue,
      randomKey: randomKey,
    );

    try {
      final useCase = locator<GetBlogOverviewListUseCase>();
      final result = await useCase.call(params);

      result.fold(
        onSuccess: (paginatedResult) async {
          print(
              'Blog Page Success: ${paginatedResult.items.length} items'); // 디버그 로그
          final newItems = paginatedResult.items..shuffle();
          final isLastPage = !paginatedResult.hasMore &&
              paginatedResult.hasReversedQueryCallProceeded;

          if (paginatedResult.hasReversedQueryCallProceeded == true) {
            hasReversedQueryCallProceeded = true;
          }

          if (isLastPage) {
            pagingController.appendLastPage(newItems);
          } else {
            pagingController.appendPage(
                newItems,
                paginatedResult.lastDocument
                    as DocumentSnapshot<BlogMainModel>?);
          }
        },
        onFailure: (error) {
          print('Blog Page Error: $error'); // 디버그 로그
          pagingController.error = error;
        },
      );
    } catch (error) {
      print('Blog Page Exception: $error'); // 디버그 로그
      pagingController.error = error;
    }
  });

  ref.onDispose(() {
    print('Blog Pagination Provider Disposed: ${category.id}'); // 디버그 로그
    pagingController.dispose();
  });

  return pagingController;
}
