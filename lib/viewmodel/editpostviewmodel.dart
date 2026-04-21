import 'dart:async';

import 'package:challenge_final_project/model/postmodel.dart';
import 'package:challenge_final_project/repository/authrepo.dart';
import 'package:challenge_final_project/repository/postrepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPostViewModel extends AsyncNotifier<void> {
  @override
  FutureOr build() {
    // TODO: implement build
    return null;
  }

  Future<void> uploadPost(String content, String mood) async {
    print("viewmodel 시작");
    final userId = ref.read(authRepoProvider).uid;
    final post = PostModel(
      mood: mood,
      content: content,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      userId: userId ?? "",
    );
    print("loading");
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      print("upload 시작");
      await ref.read(postRepoProvider).uploadPost(post.toJson());
    });
  }
}

final editpostViewModelProvider =
    AsyncNotifierProvider<EditPostViewModel, void>(() => EditPostViewModel());
