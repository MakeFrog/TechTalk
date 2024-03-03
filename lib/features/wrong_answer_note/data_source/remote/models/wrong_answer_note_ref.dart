import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/user/data_source/remote/users_ref.dart';
import 'package:techtalk/features/wrong_answer_note/data_source/remote/models/wrong_answer_note_model.dart';

abstract class FirestoreWrongAnswerNoteRef {
  static const String name = 'WrongAnswers';

  static CollectionReference<WrongAnswerNoteModel> collection() =>
      FirestoreUsersRef.doc().collection(name).withConverter(
            fromFirestore: WrongAnswerNoteModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<WrongAnswerNoteModel> doc(String id) =>
      FirestoreUsersRef.doc().collection(name).doc(id).withConverter(
            fromFirestore: WrongAnswerNoteModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
