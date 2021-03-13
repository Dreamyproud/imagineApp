import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
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
      throw "Can't get posts.";
    }
  }

  Future<List<PostModel>> createPosts(int id, String summary) async {
    id = 3;
    Response res = await post(createPath);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<PostModel> posts = body
          .map(
            (dynamic item) => PostModel.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't create posts.";
    }
  }

  Future<void> deletePost(int id) async {
    Response res = await delete(deletePath + id.toString());
    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Can't delete post.";
    }
  }
}
