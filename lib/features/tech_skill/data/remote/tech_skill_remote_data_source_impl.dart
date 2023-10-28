import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/tech_skill/data/models/tech_skill_model.dart';
import 'package:techtalk/features/tech_skill/data/remote/tech_skill_remote_data_source.dart';

class TechSkillRemoteDataSourceImpl implements TechSkillRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<TechSkillModel> get _techSkillCollection =>
      _firestore.collection(FirestoreCollection.techSkills.name).withConverter(
            fromFirestore: (snapshot, _) =>
                TechSkillModel.fromFirestore(snapshot),
            toFirestore: (value, _) => value.toJson(),
          );

  @override
  Future<List<TechSkillModel>> searchTechSkillList(String keyword) async {
    final snapshot = await _techSkillCollection
        .where(
          'name',
          isGreaterThanOrEqualTo: keyword,
        )
        .where(
          'name',
          isLessThanOrEqualTo: '$keyword~',
        )
        .get();

    final techSkillList = snapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    return techSkillList;
  }
}
