import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'skill_field_controller_provider.g.dart';

@riverpod
class SkillFieldController extends _$SkillFieldController {
  @override
  Raw<TextEditingController> build() {
    return TextEditingController();
  }
}
