import 'dart:convert';

import 'package:blogapp/entity/blog_entity.dart';
import 'package:http/http.dart' as http;

class BlogApi {

  // Static instance + private Constructor for simple Singleton-approach - More here: https://jake-knowledge.notion.site/Singleton-approach-16525cbf251d4739871ecec7cd2913f3?pvs=4
  // Singleton-Muster: Stellt sicher, dass es nur eine Instanz der Klasse gibt
  static BlogApi instance = BlogApi._privateConstructor();
  // Privater Konstruktor verhindert die Erstellung weiterer Instanzen
  BlogApi._privateConstructor();

  // URL und Header für die Appwrite-API
  final String _baseUrl = 'https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Appwrite-Project': '6568509f75ac404ff6ae',
    'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'
  };

  Future<List<Blog>> fetchBlogs() async {

    //query for sorting and limiting
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      "queries[0]": "orderDesc('\$createdAt')",
      "queries[1]": "limit(100)",
    });

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      // Parse the JSON data
      var jsonData = jsonDecode(response.body);
      List<dynamic> blogsJson = jsonData['documents'];
      return blogsJson.map((json) => Blog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs. Status code: ${response.statusCode}');
    }
  }

  Future<Blog> getBlogbyId({required String blogId}) async {
    final response = await http.get(Uri.parse('$_baseUrl/$blogId'), headers: _headers);

    if(response.statusCode == 200) {   // 200 = OK
      var jsonData = jsonDecode(response.body);
      return Blog.fromJson(jsonData);
    } else {
      throw Exception('Failed to load blog. Status code: ${response.statusCode}');
    }
  }

  Future<void> addBlog({
    required String title,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _headers,
      body: jsonEncode({
        "documentId": "unique()",
        "data": {
          "title": title,
          "content": content
        }
      }),
    );
    if (response.statusCode != 201) {
      print('Failed to create blog. Response: ${response.body}');
      throw Exception(
          'Failed to create blog. Status code: ${response.statusCode}');
    }
  }


  Future<void> patchBlog({
    required String blogId,
    required String title,
    required String content,
  }) async {
    var patchBody = {
      "document" : blogId,
      "data": {
        "title": title,
        "content": content,
      }
    };
    final response = await http.patch(Uri.parse('$_baseUrl/$blogId'), headers: _headers, body: jsonEncode(patchBody));
    if (response.statusCode != 200) {   // 200 = OK
      throw Exception(
          'Failed to update blog. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteBlog({required String blogId}) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$blogId'), headers: _headers);
    if (response.statusCode != 204) {   // 204 = No Content
      throw Exception(
          'Failed to delete blog. Status code: ${response.statusCode}');
    }
  }



}