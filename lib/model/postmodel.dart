class PostModel {
  final String mood;
  final String content;
  final int createdAt;
  final String? userId;
  final String? docId;

  PostModel({
    required this.mood,
    required this.content,
    required this.createdAt,
    this.userId,
    this.docId,
  });

  PostModel.fromJson(Map<String, dynamic> json, String docuId)
    : mood = json["mood"],
      content = json["context"],
      createdAt = json["createdAt"],
      userId = json["userId"],
      docId = json["docuId"];

  Map<String, dynamic> toJson() {
    return {
      "mood": mood,
      "content": content,
      "createdAt": createdAt,
      "userId": userId,
      "docId": docId,
    };
  }

  PostModel copyWith({
    String? mood,
    String? content,
    int? createdAt,
    String? userId,
    String? docId,
  }) {
    return PostModel(
      mood: mood ?? this.mood,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      docId: docId ?? this.docId,
    );
  }
}
