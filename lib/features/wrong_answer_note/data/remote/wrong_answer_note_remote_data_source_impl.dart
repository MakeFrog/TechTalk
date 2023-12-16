import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/models/wrong_answer_qna_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TopicQuestionModel>> _tempData() async {
    final jsonString = [
      {
        "id": "a7aa4f70-e46b-422f-993e-1968e3956b54",
        "chat_room_id": "0cbdf72b-bd53-445f-ad60-88136fcc7f9c",
        "qna_id": "d8e1462a-c5e1-4151-8db1-0effb37aaad5",
        "question_id": "q-29"
      },
      {
        "id": "37c23365-6d1f-4517-80a2-f965fb0d02f7",
        "chat_room_id": "89a317d8-3021-4b9b-84ab-8d23dcdad809",
        "qna_id": "f399ea32-59b4-4381-99d4-b0f4ad553422",
        "question_id": "q-22"
      },
      {
        "id": "05b12edf-7a44-4170-9da3-a5a408e4e14f",
        "chat_room_id": "b23349f8-d5e1-4443-835e-7817a310d94b",
        "qna_id": "66fc141f-eac8-4ef2-8a24-6142d66f7647",
        "question_id": "q-44"
      },
      {
        "id": "6c31bd34-ee30-4242-875b-4d86dc03b967",
        "chat_room_id": "77afd93e-567e-4e8c-9340-78eabede1290",
        "qna_id": "72292f35-47f2-4898-89ea-032b0bd82c79",
        "question_id": "q-33"
      },
      {
        "id": "bb0441b6-1de3-47e0-b78d-9071c06369f7",
        "chat_room_id": "bacbe72a-227d-4fc0-99d4-b92ad559535f",
        "qna_id": "a65bd204-522e-4dfe-a387-7b1b79d56340",
        "question_id": "q-50"
      },
      {
        "id": "e993d77e-dfed-4b20-a134-17c497e318aa",
        "chat_room_id": "4c55095c-f176-4aa8-9691-37829747c565",
        "qna_id": "a04595a0-0b8c-42a9-94aa-6ce95c0ff470",
        "question_id": "q-29"
      },
      {
        "id": "cd3fc70f-d41e-4d19-8e00-077231b43bff",
        "chat_room_id": "44fb97a0-f006-408e-8936-e52fd182646b",
        "qna_id": "2dd06200-384e-4c79-86bb-2175d54d81b4",
        "question_id": "q-34"
      },
      {
        "id": "363bdc4e-95a7-4376-82ed-bf41a97f9c3e",
        "chat_room_id": "c826623f-e70b-4c28-97ab-d78a30491cac",
        "qna_id": "55ecb090-e027-46d2-90d3-dd7245663bb0",
        "question_id": "q-31"
      },
      {
        "id": "00515fdd-5870-4db3-8017-c415eeefb236",
        "chat_room_id": "1e7bdb0a-cf64-47ae-92b6-8781ec9818f2",
        "qna_id": "47394683-78a5-461a-9585-d0e9f90d3d95",
        "question_id": "q-37"
      },
      {
        "id": "5e1dc200-4dbf-4179-9c52-d4246ece11aa",
        "chat_room_id": "fc2b4b8e-d875-4537-93e7-64a4a546a777",
        "qna_id": "aa5884d5-6a91-4910-8782-2157b55de0fc",
        "question_id": "q-30"
      },
      {
        "id": "43f14c29-f884-4f6d-813e-a04786af1f6a",
        "chat_room_id": "f8a01b07-e3f8-4b00-a655-6baf19498af2",
        "qna_id": "7518f85b-5923-4783-b09e-e6f861a8f10e",
        "question_id": "q-8"
      },
      {
        "id": "aa0afd4e-4ba0-463d-b63e-f88ab63e1f12",
        "chat_room_id": "f4b4b51e-8d71-4075-a97f-770017789cdd",
        "qna_id": "fa558698-53e4-4c97-847a-ba02a4b509f4",
        "question_id": "q-11"
      },
      {
        "id": "fdf2b97a-9683-41a4-a55e-8f476140888c",
        "chat_room_id": "27c08922-2950-417a-9700-6e444d0549aa",
        "qna_id": "e4826ad1-722d-4a71-bc19-db4a12fb06e6",
        "question_id": "q-41"
      },
      {
        "id": "14320e89-9586-4ae2-bcd4-4449a121ab2a",
        "chat_room_id": "3c5ee556-fbba-453b-a8a1-cb9d2b5d1a31",
        "qna_id": "5522fed0-be68-4a78-b185-14fcde00867f",
        "question_id": "q-50"
      },
      {
        "id": "04f023b1-2112-4aeb-874f-22bea481abff",
        "chat_room_id": "3320bb01-e096-4cce-940c-707a270ab337",
        "qna_id": "72569ac5-3ed6-46e0-a7ba-14c993180191",
        "question_id": "q-49"
      },
      {
        "id": "dbd063a1-f32f-4b5f-bc93-b7ccf8b229c7",
        "chat_room_id": "8e9d8582-e4f5-4164-bba3-9889495f7510",
        "qna_id": "24950685-0458-49a7-8657-e67e3c967a9e",
        "question_id": "q-35"
      },
      {
        "id": "f256f06a-3de8-4124-baa7-9dba39dbfd0a",
        "chat_room_id": "75c800b7-1a46-4288-9dc4-fdcaed1f6efd",
        "qna_id": "83fcd439-b662-4e75-acbb-13c8335db038",
        "question_id": "q-28"
      },
      {
        "id": "0188e0f1-3326-4adc-ad6b-394863e0e1b0",
        "chat_room_id": "3dfccda1-76c3-45b6-a905-b7f1a481235f",
        "qna_id": "c2790d26-3dd8-4997-b89e-1ecb5ad272bf",
        "question_id": "q-7"
      },
      {
        "id": "aeea70b3-60d3-4fe9-ae6e-1a0cb4d8cdd9",
        "chat_room_id": "60a09864-bba5-4005-bd92-5079b9715828",
        "qna_id": "b4ca72a8-c24e-4ece-86e2-a8fd7f20a5a1",
        "question_id": "q-29"
      },
      {
        "id": "86f32245-704c-41ad-bbf3-49e73d7c7fce",
        "chat_room_id": "c316f14e-d0b8-4385-bbf0-ad4c0f3927c0",
        "qna_id": "2486c3da-39ae-4ee2-b1e9-682f9b760fbd",
        "question_id": "q-5"
      },
      {
        "id": "5bfb9c17-f4b5-43d7-8f30-ffabfd4014d7",
        "chat_room_id": "b84392ef-2a89-4dfb-86c9-1c54ddf495fb",
        "qna_id": "23d9a9e4-5895-475c-b9ab-639c9021fd25",
        "question_id": "q-39"
      },
      {
        "id": "13060089-5ef4-45a9-8b09-98ff00d35cd8",
        "chat_room_id": "d8ec5a65-92bf-41f9-a345-935c031f1f30",
        "qna_id": "4cbabef9-a70f-4c20-a8d2-c1e76da0a0f1",
        "question_id": "q-42"
      },
      {
        "id": "28c9be1c-d6bb-43b7-9f2e-0e406716fc13",
        "chat_room_id": "012ae00d-9cda-4055-a2cd-f648ab87d5ea",
        "qna_id": "d4253927-5849-4e45-bfbf-098b7e9018f2",
        "question_id": "q-44"
      },
      {
        "id": "3c77283c-d3b5-4386-91d2-ab09719a9cbf",
        "chat_room_id": "1e264ffe-aced-43ec-aa3a-184ddb1ca967",
        "qna_id": "34169e1e-d225-4194-9c6f-c74b88df647b",
        "question_id": "q-26"
      },
      {
        "id": "db0ffbec-346d-460e-b7f6-245b50e45d04",
        "chat_room_id": "f177c6c5-b394-4b37-b25b-bb37593a3b5c",
        "qna_id": "9bc0907d-a2e2-43a1-aef9-33e862a4c79f",
        "question_id": "q-42"
      },
      {
        "id": "71adff9b-be03-470e-819b-6ce8fbee6d98",
        "chat_room_id": "b6ba3bbb-56d4-46ea-8d99-6d3a85fde80c",
        "qna_id": "ef39a62c-d05e-4589-a2c8-4b697187a147",
        "question_id": "q-15"
      },
      {
        "id": "f717ad11-85dc-4823-ab79-9ec624c5d423",
        "chat_room_id": "b0919b40-b048-444e-a7a8-10582dc73004",
        "qna_id": "a18de197-34b3-475a-84fa-c8f4edaedfcc",
        "question_id": "q-44"
      },
      {
        "id": "ca859320-701f-46d4-8b79-06dddc97ea72",
        "chat_room_id": "a785240f-81a5-4bb6-9907-86038c1de800",
        "qna_id": "3b755541-f612-4916-afc8-6e0ca5cb44df",
        "question_id": "q-7"
      },
      {
        "id": "801b7a2b-63e6-48f4-a3b0-edcca914df59",
        "chat_room_id": "249d170e-47ee-48fe-8765-99c080d160a0",
        "qna_id": "d119b4ff-6e15-4cac-812b-d3500c4eda4c",
        "question_id": "q-30"
      },
      {
        "id": "c078f12b-446e-4de9-be77-ede5198658aa",
        "chat_room_id": "a3470d83-d9ba-469b-abfd-279cf3674c45",
        "qna_id": "d3127905-13de-419e-be87-c06910317eba",
        "question_id": "q-46"
      },
      {
        "id": "807ee84f-e11c-4b60-9e5c-6b8aed905018",
        "chat_room_id": "25eff219-6d26-496b-ae17-67b28682de08",
        "qna_id": "06d00e56-e9b1-41da-850e-c692feb9aec1",
        "question_id": "q-45"
      },
      {
        "id": "f7631215-8b5a-4f9f-98a5-aa12b86d9cb9",
        "chat_room_id": "99498d23-49a8-4ca6-b747-9ecc35584a66",
        "qna_id": "a86e4b99-6aa0-4a07-ba18-9fe3d88f3edb",
        "question_id": "q-42"
      },
      {
        "id": "5268f4fc-0799-4527-ba6e-eb390fe214b5",
        "chat_room_id": "75182011-6e5d-498d-a6ce-38c02602a958",
        "qna_id": "40e5360c-a3b1-4c57-92ba-4f59fde2ab8f",
        "question_id": "q-18"
      },
      {
        "id": "09c7d05c-5f30-4af4-9f9f-561b4b7465fa",
        "chat_room_id": "927827f7-74c6-40bb-8f4b-555747876805",
        "qna_id": "76406cfc-0a91-4702-9077-5377eaa31bc5",
        "question_id": "q-7"
      },
      {
        "id": "962da7d9-6bf1-4d97-9e5a-be565f7d57b2",
        "chat_room_id": "601c2cbc-8cca-4edd-9253-5a10615eeae1",
        "qna_id": "781c8f63-0d3b-4430-94e6-b222fe9460dd",
        "question_id": "q-45"
      },
      {
        "id": "515a8af5-3b77-4b25-aea2-182ea73413d9",
        "chat_room_id": "c9fd3ac0-92fe-4208-b0c2-2e00e6b54f57",
        "qna_id": "b3fab9e1-a382-49b4-8a7d-719ac0fd4890",
        "question_id": "q-40"
      },
      {
        "id": "a203a567-bfe0-4380-8762-92ce4c364663",
        "chat_room_id": "6b20cccc-6804-4b15-b854-853736a18c04",
        "qna_id": "0c06cfbf-fee5-4649-93f1-bfe4cbc7c0ce",
        "question_id": "q-10"
      },
      {
        "id": "86aa39ea-1444-4e95-b739-7c99b51c7ced",
        "chat_room_id": "08799a7c-9e6c-4c48-9aae-1e47499b2663",
        "qna_id": "91f8559e-a240-4180-bc86-991fecbc55fc",
        "question_id": "q-43"
      },
      {
        "id": "f7c56a6f-b709-4fd4-b33f-6725f37ea03f",
        "chat_room_id": "c8c12aaa-b2b8-41b2-93cb-2abefd29b994",
        "qna_id": "a0957c27-7a79-4a3b-94f2-8e19bff7f532",
        "question_id": "q-22"
      },
      {
        "id": "794fb63e-d491-432f-9b23-0734147a7a1f",
        "chat_room_id": "abefb596-d781-4364-9956-ecb87feab397",
        "qna_id": "da8435fd-7849-4937-a4d3-987064991ec8",
        "question_id": "q-33"
      },
      {
        "id": "861b5752-c3c4-4847-976e-dd98a7f9ebd0",
        "chat_room_id": "bbe1764c-64dd-4d3f-88c0-d2e193f76add",
        "qna_id": "7ba719be-6476-47b7-b356-0c565663e2ac",
        "question_id": "q-12"
      },
      {
        "id": "07bc970e-28e9-4524-abc3-de4c347262a7",
        "chat_room_id": "95eded34-b4c1-4c37-bc32-a0bbaba1a869",
        "qna_id": "fdb96c09-110a-4041-ac93-4efd5c821e91",
        "question_id": "q-44"
      },
      {
        "id": "75a93f88-cf88-4c84-abf9-cdbe69b47b7d",
        "chat_room_id": "86ef6ec8-69d3-42d6-9fb1-f89cb734dd5f",
        "qna_id": "890a5111-3599-47fd-9fcd-32d09b2e4c43",
        "question_id": "q-41"
      },
      {
        "id": "5865660e-93c4-483a-9917-c1169837c58a",
        "chat_room_id": "e742b7fb-470b-418f-824a-1483767d04b4",
        "qna_id": "2decb134-b5bc-4732-bfb8-3bcca9f57c31",
        "question_id": "q-11"
      },
      {
        "id": "907c2abf-653d-4642-bca7-e005241099ad",
        "chat_room_id": "b0f4d082-db47-45a9-a436-3957c4ab13b6",
        "qna_id": "bcd34f7a-1632-4b7d-bd72-07e20b765f35",
        "question_id": "q-6"
      },
      {
        "id": "c92e42c7-03b5-4dd1-8266-03345b4dac04",
        "chat_room_id": "ad865683-437f-4e60-a37f-b4b07c94d281",
        "qna_id": "78ee6b33-54f0-4d77-8099-a61a20a21eec",
        "question_id": "q-11"
      },
      {
        "id": "d49741b7-cd31-4ff4-b982-cbf1edcc1d03",
        "chat_room_id": "8cf5710c-293c-4eeb-a5b7-e6a799d28196",
        "qna_id": "09633e71-b835-45bc-a575-fe89713effce",
        "question_id": "q-33"
      },
      {
        "id": "fa157239-ed78-4cfa-bc35-3773638c4640",
        "chat_room_id": "89424350-49e3-41b8-8ec4-4acd949470ec",
        "qna_id": "9d43ec80-2ad5-48ce-99ff-ed8c4642c948",
        "question_id": "q-2"
      },
      {
        "id": "e16f9c6f-5282-4c9a-b08f-446b9f98a0a4",
        "chat_room_id": "5fe4b906-5437-4561-a628-d614f381af26",
        "qna_id": "881b6d6c-2fb5-43b2-97bc-14b3901484cb",
        "question_id": "q-2"
      },
      {
        "id": "7aae89be-e29d-4c68-8a58-15aa8eb34a75",
        "chat_room_id": "30014a71-9bf1-438b-b4fa-901533d8cffc",
        "qna_id": "c975c81f-42da-4cbd-afa5-6bdd5d534c43",
        "question_id": "q-41"
      }
    ];

    final topicQuestionsCollection = _firestore
        .collection('interview')
        .doc('flutter')
        .collection('questions');

    return Future.wait(
      jsonString.map((e) => e['question_id'] as String).toSet().map(
            (e) async => TopicQuestionModel.fromFirestore(
              await topicQuestionsCollection.doc(e).get(),
            ),
          ),
    );
  }

  @override
  Future<List<TopicQuestionModel>> getQuestions({
    required String userUid,
    required String topicId,
  }) async {
    return _tempData();

    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.wrongAnswers.name)
        .doc(topicId)
        .collection('qna')
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    final data = snapshot.docs
        .map(WrongAnswerQnAModel.fromFirestore)
        .map((e) => e.questionId)
        .toSet();
    final topicQuestionsCollection =
        _firestore.collection('interview').doc(topicId).collection('questions');

    final questions = data.map(
      (e) async => TopicQuestionModel.fromFirestore(
        await topicQuestionsCollection.doc(e).get(),
      ),
    );

    return Future.wait(questions);
  }
}
