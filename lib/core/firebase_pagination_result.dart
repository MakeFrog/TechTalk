import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePaginatedResult<Data, PageKey> {
  FirebasePaginatedResult({
    required this.items,
    this.lastDocument,
    this.lastDocumentId,
    required this.hasMore,
    this.hasReversedQueryCallProceeded = false,
  });

  final List<Data> items;
  final DocumentSnapshot<PageKey>? lastDocument;
  final String? lastDocumentId;
  final bool hasMore;
  final bool hasReversedQueryCallProceeded; // isLessThan 여부를 반환
}
