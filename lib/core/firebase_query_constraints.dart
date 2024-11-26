import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore 쿼리 제약 조건의 추상 클래스
abstract class FirestoreQueryConstraint {
  /// 쿼리에 제약 조건을 적용하는 메서드
  Query<T> apply<T>(Query<T> query);
}

/// 특정 필드가 주어진 값과 같은지 비교하는 제약 조건
class EqualToConstraint extends FirestoreQueryConstraint {
  final String fieldName; // 필드 경로
  final dynamic value; // 비교할 값

  EqualToConstraint({required this.fieldName, required this.value});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldName, isEqualTo: value); // 필드가 값과 같은지 조건 추가
  }
}

/// 특정 필드의 배열에 주어진 값이 포함되어 있는지 비교하는 제약 조건
class ArrayContainsConstraint extends FirestoreQueryConstraint {
  final String fieldPath; // 필드 경로
  final dynamic value; // 포함 여부를 확인할 값

  ArrayContainsConstraint({required this.fieldPath, required this.value});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldPath, arrayContains: value); // 배열에 값이 포함되어 있는지 조건 추가
  }
}

/// 특정 필드의 배열에 주어진 값들 중 하나 이상이 포함되어 있는지 비교하는 제약 조건
class ArrayContainsAnyConstraint extends FirestoreQueryConstraint {
  final String fieldPath; // 필드 경로
  final List<dynamic> values; // 포함 여부를 확인할 값들의 리스트

  ArrayContainsAnyConstraint({required this.fieldPath, required this.values});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldPath, arrayContainsAny: values); // 배열에 값들 중 하나 이상이 포함되어 있는지 조건 추가
  }
}

/// 특정 필드의 값이 주어진 값보다 큰지 비교하는 제약 조건
class GreaterThanConstraint extends FirestoreQueryConstraint {
  final String fieldPath; // 필드 경로
  final dynamic value; // 비교할 값

  GreaterThanConstraint({required this.fieldPath, required this.value});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldPath, isGreaterThan: value); // 값보다 큰지 조건 추가
  }
}

/// 특정 필드의 값이 주어진 값보다 작은지 비교하는 제약 조건
class LessThanConstraint extends FirestoreQueryConstraint {
  final String fieldPath; // 필드 경로
  final dynamic value; // 비교할 값

  LessThanConstraint({required this.fieldPath, required this.value});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldPath, isLessThan: value); // 값보다 작은지 조건 추가
  }
}

/// 특정 필드의 값이 주어진 값들 중 하나인지를 비교하는 제약 조건
class WhereInConstraint extends FirestoreQueryConstraint {
  final String fieldPath; // 필드 경로
  final List<dynamic> values; // 비교할 값들의 리스트

  WhereInConstraint({required this.fieldPath, required this.values});

  @override
  Query<T> apply<T>(Query<T> query) {
    return query.where(fieldPath, whereIn: values); // 값들 중 하나와 일치하는지 조건 추가
  }
}
