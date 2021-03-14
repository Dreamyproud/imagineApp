import 'dart:convert';

List<PostCreateModel> welcomeFromJson(String str) => List<PostCreateModel>.from(
    json.decode(str).map((x) => PostCreateModel.fromJson(x)));

String welcomeToJson(List<PostCreateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostCreateModel {
  PostCreateModel({
    this.userId,
    this.summary,
  });

  int userId;
  String summary;

  factory PostCreateModel.fromJson(Map<String, dynamic> json) =>
      PostCreateModel(
        userId: json["userId"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "summary": summary,
      };
}
