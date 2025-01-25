import 'package:techtalk/app/di/index.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/usecases/analyze_youtube_use_case.dart';

export 'data_source/remote/models/channel_model.dart';
export 'data_source/remote/models/paragraph_model.dart';
export 'data_source/remote/models/summary_model.dart';
export 'data_source/remote/models/youtube_detail_model.dart';
export 'data_source/remote/models/youtube_main_entity.dart';
export 'data_source/remote/models/youtube_main_model.dart';
export 'data_source/remote/models/youtube_qna_model.dart';
export 'data_source/remote/youtube_ref.dart';
export 'data_source/remote/youtube_remote_data_source.dart';
export 'data_source/remote/youtube_remote_data_source_impl.dart';
export 'repositories/entities/caption_entity.dart';
export 'repositories/entities/channel_entity.dart';
export 'repositories/entities/paragraph_entity.dart';
export 'repositories/entities/summary_entity.dart';
export 'repositories/entities/youtube_ai_qna_response.dart';
export 'repositories/entities/youtube_ai_summary_response_entity.dart';
export 'repositories/entities/youtube_core_video_entity.dart';
export 'repositories/entities/youtube_video_entity.dart';
export 'repositories/enums/youtube_content_analyzed_type.dart';
export 'repositories/youtube_repository.dart';
export 'repositories/youtube_repository_impl.dart';
export 'usecases/enums/youtube_upload_failed_type.dart';
export 'usecases/exception/youtube_upload_exception.dart';
export 'usecases/get_qnas_from_youtube_content_use_case.dart';
export 'usecases/get_skill_ids_from_youtube_content_use_case.dart';
export 'usecases/get_summary_from_youtube_content_use_case.dart';
export 'usecases/get_youtube_overview_list_use_case.dart';
export 'usecases/get_youtube_video_data_use_case.dart';

final youtubeRepository = locator<YoutubeRepository>();
final youtubeRemoteDataSource = locator<YoutubeRemoteDataSource>();
final getYoutubeVideoDataUseCase = locator<GetYoutubeVideoDataUseCase>();
final getYoutubeOverviewListUseCase = locator<GetYoutubeOverviewListUseCase>();
final analyzeAndUploadYoutubeUseCase =
    locator<AnalyzeAndUploadYoutubeUseCase>();
