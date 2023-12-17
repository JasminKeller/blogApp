import 'package:blogapp/providers/blog_provider.dart';
import 'package:flutter/foundation.dart';

import '../entity/blog_entity.dart';
import 'blog_api.dart';

class BlogRepository {       // aka BlogService
  // Static instance + private Constructor for simple Singleton-approach - More here: https://jake-knowledge.notion.site/Singleton-approach-16525cbf251d4739871ecec7cd2913f3?pvs=4
  // Singleton-Muster: Stellt sicher, dass es nur eine Instanz der Klasse gibt
  static BlogRepository instance = BlogRepository._privateConstructor();
  // Privater Konstruktor verhindert die Erstellung weiterer Instanzen
  BlogRepository._privateConstructor();


  final _blogs = <Blog>[];

  Future<List<Blog>> getBlogs() async {
    if (kDebugMode) {
      print('BlogApi.instance.fetchBlogs()');
    }

    return BlogApi.instance.fetchBlogs();
  }

  Future<void> addBlog(BlogProvider blogProvider, {required String title, required String content,}) async{
      await BlogApi.instance.addBlog(title: title, content: content);
      await blogProvider.readBlogsWithLoadingState();
  }

  Future<void> deleteBlog(BlogProvider blogProvider, String blogId) async {
    await BlogApi.instance.deleteBlog(blogId: blogId);
    await blogProvider.readBlogsWithLoadingState();
  }

  Future<void> updateBlog({required String blogId, required String title, required String content}) async {
    final blogIndex = _blogs.indexWhere((blog) => blog.id == blogId);
    if (blogIndex != -1) {
      final blog = _blogs[blogIndex];
      blog.title = title;
      blog.content = content;
    }
  }

  Future<Blog> getBlogById(int blogId) async {
    return _blogs.firstWhere((blog) => blog.id == blogId);
  }

}