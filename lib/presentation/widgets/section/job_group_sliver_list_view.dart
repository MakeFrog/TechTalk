import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class JobGroupSliverListView extends SliverList {
  JobGroupSliverListView(
      {super.key,
      required List<JobGroupEntity> selectedJobGroups,
      required Function(JobGroupEntity) onItemTap})
      : super.builder(
          itemBuilder: (context, index) {
            final item = techSetRepository.getJobs()[index];
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
          itemCount: techSetRepository.getJobs().length,
        );
}
