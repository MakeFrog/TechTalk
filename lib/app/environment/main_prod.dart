import 'package:techtalk/app/environment/environment.dart';
import 'package:techtalk/app/environment/environment_type.enum.dart';

Future<void> main() {
  return Environment.init(EnvironmentType.prod).run();
}
