import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skills_result_model.dart';

part 'tech_set_remote_data_source.g.dart';

final String baseUrl =
    'https://${Flavor.env.firebaseId}-default-rtdb.asia-southeast1.firebasedatabase.app';

@RestApi()
abstract class TechSetRemoteDataSource {
  @GET('/skills.json')
  Future<SkillsResultModel> getSkills();

  // Factory constructor for Retrofit
  factory TechSetRemoteDataSource(Dio dio, {String? baseUrl}) {
    return _TechSetRemoteDataSource(dio, baseUrl: baseUrl);
  }
}
