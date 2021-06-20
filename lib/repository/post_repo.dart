import 'dart:convert';

import 'package:api_bloc/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  Future<List<PostModel>> fetchPosts() async {
    List<PostModel> posts = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((post) => posts.add(PostModel.fromJson(post))).toList();
      return posts;
    }
  }
}
