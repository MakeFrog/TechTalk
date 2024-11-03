import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/contents/repositories/contents_repository.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_video_data_use_case.dart';

export 'contents.dart';
export 'repositories/contents_repository.dart';
export 'repositories/contents_repository_impl.dart';
export 'repositories/entities/contents_author_entity.dart';
export 'repositories/entities/contents_detail_entity.dart';
export 'repositories/entities/contents_overview_entity.dart';
export 'repositories/entities/paragraph_entity.dart';
export 'repositories/entities/summary_entity.dart';
export 'repositories/entities/youtube_video_data_entity.dart';
export 'usecases/get_youtube_video_data_use_case.dart';

final contentsRepository = locator<ContentsRepository>();
final getYoutubeVideoDataUseCase = locator<GetYoutubeVideoDataUseCase>();
