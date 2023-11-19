extension ListExtension<T> on List<T> {
  T get secondToLast {
    if (length < 2) {
      throw Exception('at least 2 element is needed');
    }
    return this[length - 2];
  }

  int? firstIndexWhereOrNull(bool Function(T element) test) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        return i;
      }
    }
    return null;
  }
}
