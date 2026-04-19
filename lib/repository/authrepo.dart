import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;
  bool get isLogedIn => _auth.currentUser != null;
  String? get email => _auth.currentUser?.email;
  Stream<User?> get userStream => _auth.authStateChanges();

  Future<void> signUpRepo(Map<String, dynamic> userInfo) async {
    await _auth.createUserWithEmailAndPassword(
      email: userInfo["email"],
      password: userInfo["password"],
    );
  }
}

// Riverpod의 Provider들은 보통 이렇게 클래스 밖에 '전역'으로 선언합니다.

final authRepoProvider = Provider((ref) => AuthRepository());

final authMapProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final authStreamProvider = StreamProvider<User?>((ref) {
  final repo = ref.watch(authRepoProvider);
  return repo.userStream;
});
