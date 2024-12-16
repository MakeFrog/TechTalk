import 'package:techtalk/features/tech_set/repositories/entities/skill_set_entity.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:techtalk/core/index.dart';

final class GetSearchedSkillSetUseCase {
  List<Map<String, dynamic>> jsonData = [];

  Future<Result<List<SkillSetEntity>>> call(String query) async {
    try {
      if (jsonData.isEmpty) {
        final jsonString = await rootBundle.loadString(Assets.jsonStack);

        // json.decode 결과를 적절히 캐스팅
        final List<dynamic> parsedJson = json.decode(jsonString);
        jsonData = parsedJson
            .whereType<Map<String, dynamic>>() // Map<String, dynamic>만 필터링
            .toList();
      }

      // 검색어를 소문자로 변환합니다.
      final lowerCaseQuery = query.toLowerCase();

      // 검색어와 일치하는 데이터를 필터링합니다.
      final result = jsonData
          .where((item) =>
              item['name'].toString().toLowerCase().contains(lowerCaseQuery))

          /// TODO : XIMYA
          .map((e) => SkillSetEntity.fromJson(json: e, category: ''))
          .toList();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
