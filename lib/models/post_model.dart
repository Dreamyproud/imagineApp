import 'dart:convert';

List<PostModel> welcomeFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String welcomeToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.id,
    this.name,
    this.image,
    this.position,
    this.date,
    this.summary,
  });

  int id;
  String name;
  String image;
  String position;
  String date;
  String summary;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    position: json["position"],
    date: json["date"],
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "position": position,
    "date": date,
    "summary": summary,
  };
}
