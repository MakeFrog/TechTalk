extension ListExtension<T> on List<T> {
  T get secondLast {
    if (length < 2) {
      throw Exception('at least 2 element is needed');
    }
    return this[length - 2];
  }

  int? firstIndexWhereOrNull(bool Function(T element) test) {
    final index = indexWhere(test);

    return index != -1 ? index : null;
  }

  List<T> extractElementsBefore(T element) {
    final index = indexOf(element);

    if (index == -1 || index == 0) {
      return [];
    }

    return sublist(0, index + 1);
  }

  ///
  /// 주어진 배열의 원소들이 모두 동일한지 확인하는 메소드
  /// 이때 원소들 순서는 고려하지 않음.
  ///
  bool isElementEquals(List<T>? comparedArray) {
    if (comparedArray == null || length != comparedArray.length) {
      return false;
    }
    if (identical(this, comparedArray)) {
      return true;
    }

    for (int index = 0; index < length; index += 1) {
      if (!contains(comparedArray[index])) {
        return false;
      }
    }
    return true;
  }

  ///
  /// 주어진 배열을 처음 원소를 시작 값으로
  /// sublist 한 이후 shuffle한 값을 리턴
  ///
  List<T> extractFromFirstAndShuffle(int end) {
    final newList = this;
    newList.shuffle();
    final filteredList = newList.sublist(0, end);

    return filteredList;
  }

  ///
  /// 기존 배열에 중복되지 않는 요소들만 추가한 리스트를 리턴
  ///
  List<T> toCombinedSetList(List<T> elements) {
    final prevList = toList();
    prevList.addAll(elements);
    final setList = prevList.toSet();

    return setList.toList();
  }

  ///
  /// 배열에 첫 번째 공간에 원소를 추가하는 메소드
  ///
  void addFirst(T element) {
    insert(0, element);
  }
}
