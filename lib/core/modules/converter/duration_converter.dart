import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration?, int?> {
  const DurationConverter();

  @override
  Duration? fromJson(int? json) {
    if (json == null) return Duration.zero;
    return Duration(seconds: json);
  }

  @override
  int? toJson(Duration? object) => object?.inSeconds;
}
