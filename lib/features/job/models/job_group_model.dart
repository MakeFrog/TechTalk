import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_group_model.freezed.dart';
part 'job_group_model.g.dart';

@freezed
class JobGroupModel with _$JobGroupModel {
  const factory JobGroupModel({
    required String id,
    required String name,
  }) = _JobGroupModel;

  factory JobGroupModel.fromFirestore(String id, Map<String, dynamic> data) =>
      JobGroupModel(
        id: id,
        name: data['name'],
      );
  factory JobGroupModel.fromJson(Map<String, dynamic> json) =>
      _$JobGroupModelFromJson(json);
}

@freezed
class JobGroupListModel with _$JobGroupListModel {
  const factory JobGroupListModel({
    required List<JobGroupModel> groups,
  }) = _JobGroupListModel;

  factory JobGroupListModel.fromJson(Map<String, dynamic> json) =>
      _$JobGroupListModelFromJson(json);
}
