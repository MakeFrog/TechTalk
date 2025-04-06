import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';

///
/// 선택 여부 flag값을 가지고 있는 qna entity
///
final class SelectableQnaEntity<T extends BaseQnaEntity> {
  final bool isSelected;
  final T qna;

  const SelectableQnaEntity({required this.isSelected, required this.qna});

  SelectableQnaEntity copyWith({
    bool? isSelected,
    T? qna,
  }) {
    return SelectableQnaEntity(
      isSelected: isSelected ?? this.isSelected,
      qna: qna ?? this.qna,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableQnaEntity &&
          runtimeType == other.runtimeType &&
          isSelected == other.isSelected &&
          qna == other.qna;

  @override
  int get hashCode => isSelected.hashCode ^ qna.hashCode;
}
