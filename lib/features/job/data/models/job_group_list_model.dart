import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/data/models/job_group_model.dart';

part 'job_group_list_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JobGroupListModel {
  JobGroupListModel({
    required this.totalCount,
    required this.groups,
  });

  final int totalCount;
  final List<JobGroupModel> groups;

  factory JobGroupListModel.fromJson(Map<String, dynamic> json) {
    return _$JobGroupListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$JobGroupListModelToJson(this);
}
