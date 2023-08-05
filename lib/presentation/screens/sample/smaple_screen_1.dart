import 'package:flutter/material.dart';
import 'package:techtalk/domain/useCase/sample_use_case.dart';
import 'package:techtalk/main.dart';
import 'package:techtalk/presentation/base/base_screen.dart';
import 'package:techtalk/presentation/screens/sample/sample_view_model.dart';
import 'package:provider/provider.dart';

class SampleScreen1 extends BaseScreen<SampleViewModel> {
  const SampleScreen1({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Hello'),
    );
  }

  @override
  Color? get screenBackgroundColor => Colors.white;

  @override
  Widget buildScreen(BuildContext context) {
    print("aim");
    return Center(
      child: FittedBox(
        child: Column(
          children: [
            const SomeSampleView(),
            ElevatedButton(
              onPressed: () {
                vmR(context).routeToNestedScreen(context);
              },
              child: const Text('Go to NestedScreend 1'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SampleViewModel createViewModel() =>
      SampleViewModel(getIt.get<SampleUseCase>());
}

class SomeSampleView extends StatelessWidget {
  const SomeSampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.select((SampleViewModel value) {
      if (value.someValue == null) {
        return const CircularProgressIndicator();
      } else {
        return Text(value.someValue!);
      }
    });
  }
}
