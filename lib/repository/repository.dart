import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkedin/models/post_model.dart';

class Repository {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  final String postGet = "http://34.121.81.88:8070/posts/getAll";

  Future<List<PostModel>> getPosts() async {
    print("xx2");
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
      print("xx1");
      throw "Can't get posts.";
    }
  }
}
