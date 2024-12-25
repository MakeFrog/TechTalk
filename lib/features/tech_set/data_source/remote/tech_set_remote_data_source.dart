import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/tech_set_keys_model.dart';

part 'tech_set_remote_data_source.g.dart';

@RestApi()
abstract class TechSetRemoteDataSource {
  /// 스킬 항목 호출
  /// 매핑은 하위 라위에서
  @GET('/skills.json')
  Future<dynamic> getSkills();

  /// 각'TechSet' 데이터 캐싱 여부를 판단할 각 json section key값 호출
  @GET('/keys.json')
  Future<TechSetKeysModel> getKeys();

  // Factory constructor for Retrofit
  factory TechSetRemoteDataSource(Dio dio, {String? baseUrl}) {
    return _TechSetRemoteDataSource(dio, baseUrl: baseUrl);
  }
}
