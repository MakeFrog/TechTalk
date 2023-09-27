import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/presentation/app.dart';

Future<void> main() async {
  Flavor.initialize(Environment.dev);

  return runFlavoredApp();
}
