import 'package:challenge_final_project/model/postmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadPost(Map<String, dynamic> post) async {
    try {
      final docRef = _db.collection("posts").doc();
      final refpost = post;
      // 데이터에 생성된 ID 저장
      refpost['docId'] = docRef.id;
      await docRef.set(refpost);
      print("업로드 성공!");
    } catch (e) {
      print("Repository 에러: $e");
      rethrow; // ViewModel의 guard가 잡을 수 있게 던져줌
    }
  }

  Stream<List<Map<String, dynamic>>> streamPost() {
    return _db
        .collection("posts")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}

final postRepoProvider = Provider((ref) => PostRepo());

final postrepoStreamProvider = StreamProvider((ref) {
  final refer = ref.watch(postRepoProvider);
  return refer.streamPost();
});
