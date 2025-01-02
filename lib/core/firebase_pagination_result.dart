import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePaginatedResult<Data, PageKey> {
  FirebasePaginatedResult({
    required this.items,
    required this.lastDocument,
    required this.hasMore,
    required this.hasReversedQueryCallProceeded,
  });

  final List<Data> items;
  final DocumentSnapshot<PageKey>? lastDocument;
  final bool hasMore;
  final bool hasReversedQueryCallProceeded; // isLessThan 여부를 반환
}
