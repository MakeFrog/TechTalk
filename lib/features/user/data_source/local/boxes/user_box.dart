import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox extends HiveObject {
  @HiveField(0)
  final bool hasPracticalInterviewRecord;

  UserBox({required this.hasPracticalInterviewRecord});

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
  }) {
    return UserBox(
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
    );
  }

  factory UserBox.defaultValue() {
    return UserBox(
      hasPracticalInterviewRecord: false,
    );
  }
}
