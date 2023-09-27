import 'package:techtalk/src/app/environment/environment.enum.dart';
import 'package:techtalk/src/app/environment/flavor.dart';
import 'package:techtalk/src/presentation/app.dart';

Future<void> main() async {
  Flavor.initialize(Environment.prod);

  return runFlavoredApp();
}
