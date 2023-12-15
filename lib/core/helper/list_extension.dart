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
}
