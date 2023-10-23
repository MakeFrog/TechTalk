import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/presentation/app.dart';

void main() async {
  Flavor.initialize(Environment.prod);

  return runFlavoredApp();
}
