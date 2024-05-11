import 'dart:convert';

import 'package:flutterblocpagination/model/PostModel.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> loadUserWithPagination(int page) async {
    String url = 'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=${page}';
    final response = await http.get(Uri.parse(url));
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }
}
