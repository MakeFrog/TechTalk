import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';

abstract class TechSetRemoteDataSource {
  // /// 스킬 항목 호출
  // /// 매핑은 하위 라위에서
  // @GET('/skills.json')
  // Future<dynamic> getSkills();

  /// 각'TechSet' 데이터 캐싱 여부를 판단할 각 json section key값 호출
  // @GET('/keys.json')
  // Future<TechSetKeysModel> getKeys();

  Future<List<SkillModel>> getNewSkills();

// // Factory constructor for Retrofit
// factory TechSetRemoteDataSource(Dio dio, {String? baseUrl}) {
//   return _TechSetRemoteDataSource(dio, baseUrl: baseUrl);
// }
}
