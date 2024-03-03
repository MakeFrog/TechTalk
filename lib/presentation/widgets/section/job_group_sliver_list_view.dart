import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';

class JobGroupSliverListView extends SliverList {
  JobGroupSliverListView(
      {super.key,
      required List<JobGroup> selectedJobGroups,
      required Function(JobGroup) onItemTap})
      : super.builder(
          itemBuilder: (context, index) {
            final item = JobGroup.values[index];
            final isSelected = selectedJobGroups.contains(item);

            return ListTile(
              selected: isSelected,
              selectedColor: AppColor.of.black,
              selectedTileColor: AppColor.of.background1,
              minVerticalPadding: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.name,
                  style: AppTextStyle.body2,
                ),
              ),
              trailing: isSelected
                  ? FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: AppColor.of.brand2,
                      size: 20,
                    )
                  : null,
              onTap: () {
                onItemTap(item);
              },
            );
          },
          itemCount: JobGroup.values.length,
        );
}
