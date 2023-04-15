import 'package:flutter/material.dart';
import 'package:moon_dap/presentation/base/base_screen.dart';
import 'package:moon_dap/presentation/screens/sample/sample_view_model.dart';

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
    // vm(context);
    return Center(
      child: ElevatedButton(
        onPressed: () {
          vm(context).routeToNestedScreen(context);
        },
        child: const Text('Go to NestedScreend 1'),
      ),
    );
  }

  @override
  SampleViewModel createViewModel() => SampleViewModel();
}
