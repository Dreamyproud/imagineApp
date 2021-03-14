import 'dart:convert';
import 'package:http/http.dart';
import 'package:linkedin/models/post_create_model.dart';
import 'package:linkedin/models/post_model.dart';

class Repository {
  final String postGet = "http://34.121.81.88:8070/posts/getAll";
  final String deletePath = "http://34.121.81.88:8070/posts/delete?postId=";
  final String createPath = "http://34.121.81.88:8070/posts/create";

  Future<List<PostModel>> getPosts() async {
    Response res = await get(postGet);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<PostModel> posts = body
          .map(
            (dynamic item) => PostModel.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Error al crear";
    }
  }

  Future<PostCreateModel> createPosts(String summary) async {
    PostCreateModel postCreate = PostCreateModel();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({"userId": 3, "summary": summary});

    Response res = await post(createPath, headers: headers, body: msg);
    print(res.statusCode);
    if (res.statusCode == 200) {
      return postCreate;
    } else {
      throw "Error";
    }
  }

  Future<void> deletePost(int id) async {
    Response res = await delete(deletePath + id.toString());
    if (res.statusCode == 200) {
    } else {
      throw "Error al eliminar";
    }
  }
}
