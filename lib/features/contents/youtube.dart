import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_video_data_use_case.dart';

export 'repositories/entities/contents_author_entity.dart';
export 'repositories/entities/contents_overview_entity.dart';
export 'repositories/entities/paragraph_entity.dart';
export 'repositories/entities/summary_entity.dart';
export 'repositories/entities/youtube_video_data_entity.dart';
export 'repositories/youtube_contents_repository.dart';
export 'repositories/youtube_contents_repository_impl.dart';
export 'usecases/get_youtube_video_data_use_case.dart';
export 'youtube.dart';

final contentsRepository = locator<YoutubeContentsRepository>();
final getYoutubeVideoDataUseCase = locator<GetYoutubeVideoDataUseCase>();
