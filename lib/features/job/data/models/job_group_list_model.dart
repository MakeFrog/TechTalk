import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/data/models/job_group_model.dart';

part 'job_group_list_model.freezed.dart';
part 'job_group_list_model.g.dart';

@freezed
class JobGroupListModel with _$JobGroupListModel {
  const factory JobGroupListModel({
    required List<JobGroupModel> groups,
  }) = _JobGroupListModel;

  factory JobGroupListModel.fromJson(Map<String, dynamic> json) =>
      _$JobGroupListModelFromJson(json);
}
