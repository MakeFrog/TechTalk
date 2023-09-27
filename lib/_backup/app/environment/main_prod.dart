import 'package:techtalk/_backup/app/environment/environment.dart';
import 'package:techtalk/_backup/app/environment/environment_type.enum.dart';

Future<void> main() {
  return Environment.init(EnvironmentType.prod).run();
}
