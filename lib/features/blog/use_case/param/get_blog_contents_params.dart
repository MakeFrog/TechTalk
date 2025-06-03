import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';

class GetBlogContentsParams {
  final DocumentSnapshot? lastDocument;
  final int limit;
  final String orderByField;
  final List<FirestoreQueryConstraint>? queryConstraints;
  final bool isHalfOfRandomCalled;
  final double random;
  final String randomKey;

  const GetBlogContentsParams({
    this.lastDocument,
    required this.limit,
    required this.orderByField,
    this.queryConstraints,
    required this.isHalfOfRandomCalled,
    required this.random,
    required this.randomKey,
  });
}
