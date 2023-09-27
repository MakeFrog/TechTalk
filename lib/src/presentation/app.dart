import 'package:techtalk/presentation/screens/responsive_layout_builder.dart';
import 'package:techtalk/src/app/environment/environment.dart';
import 'package:techtalk/src/app/router/router.dart';
import 'package:techtalk/utilities/index.dart';

Future<void> run() async {
  await Environment.instance.setup();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '테크톡',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        SizeConfig.to.init(context);
        return ResponsiveLayoutBuilder(context, child);
      },
      routerConfig: appRouter,
    );
  }
}
