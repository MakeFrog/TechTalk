import 'dart:io';

import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/core/index.dart';

part 'widgets/save_button.dart';
part 'widgets/resume_manage_content.dart';

class ResumeManagePage extends BasePage
    with ResumeManageEvent {
  const ResumeManagePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _ResumeManageContent(),
          const Spacer(),
          const _SaveButton(),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '내 이력서');
}
