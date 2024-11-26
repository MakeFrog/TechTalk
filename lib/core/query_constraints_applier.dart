import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';

class QueryConstraintApplier {
  // 싱글톤 인스턴스를 저장할 정적 변수
  static final QueryConstraintApplier _instance = QueryConstraintApplier._internal();

  // 외부에서 인스턴스에 접근할 수 있는 팩토리 생성자
  factory QueryConstraintApplier() {
    return _instance;
  }

  // 내부 생성자
  QueryConstraintApplier._internal();

  /// 주어진 [query]에 [constraints]를 순차적으로 적용하고 수정된 쿼리를 반환합니다.
  Query<T> applyConstraints<T>(
    Query<T> query,
    List<FirestoreQueryConstraint> constraints,
  ) {
    for (var constraint in constraints) {
      query = constraint.apply(query);
    }
    return query;
  }
}
