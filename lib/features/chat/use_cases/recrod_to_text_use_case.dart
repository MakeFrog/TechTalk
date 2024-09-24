import 'dart:developer';
import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';

///
/// 녹은본을 텍스트로 변환해주는 UseCAse
///

class RecordToTextUseCase extends BaseUseCase<String, Result<String>> {
  Future<Result<String>> call(String path) async {
    try {
      Future<OpenAIAudioModel> transcription =
          OpenAI.instance.audio.createTranscription(
        file: File(path),
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.verbose_json,
        language: AppLocale.currentLocale.languageCode,
        timestamp_granularities: [OpenAIAudioTimestampGranularity.word],
      );

      final result = await transcription;

      return Result.success(result.text);
    } on Exception catch (e) {
      if(e is RequestFailedException) {
        e.message.startsWith('T');
      }
      log('RecordToTextUseCase ERROR: $e');
      return Result.failure(Exception('음성 인식 과정에서 오류가 발생했어요'));
    }
  }
}
