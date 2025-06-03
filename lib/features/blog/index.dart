import 'package:techtalk/app/di/app_binding.dart';

import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';

import 'package:techtalk/features/blog/repository/blog_repository.dart';

import 'package:techtalk/features/blog/use_case/get_blog_contents_use_case.dart';

export 'data_sources/remote/blog_remote_data_source.dart';
export 'repository/blog_repository.dart';
export 'repository/blog_repository_impl.dart';
export 'repository/entity/blog_shell_entity.dart';
export 'use_case/get_blog_contents_use_case.dart';

// Data Sources
final blogRemoteDataSource = locator<BlogRemoteDataSource>();

// Repositories
final blogRepository = locator<BlogRepository>();

// Use Cases
final getBlogOverviewListUseCase = locator<GetBlogOverviewListUseCase>();
