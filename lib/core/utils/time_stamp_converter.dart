import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

///
/// [freezed] 패키지에서 [Timestamp] 타입을 지원하지 않기 때문에
/// [Timestamp] 데이터를 [DateTime]으로 변환하도록 도와주눈 converter
///
class TimeStampConverter implements JsonConverter<DateTime, dynamic> {
  const TimeStampConverter();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
