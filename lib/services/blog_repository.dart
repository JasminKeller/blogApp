import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';

class BlogRepository {
  // Static instance + private Constructor for simple Singleton-approach - More here: https://jake-knowledge.notion.site/Singleton-approach-16525cbf251d4739871ecec7cd2913f3?pvs=4
  // Singleton-Muster: Stellt sicher, dass es nur eine Instanz der Klasse gibt
  static BlogRepository instance = BlogRepository._privateConstructor();
  // Privater Konstruktor verhindert die Erstellung weiterer Instanzen
  BlogRepository._privateConstructor();

  int _nextId = 1;
  bool _isInitialized = false;

  final _blogs = <Blog>[];

  void _initializeBlogs() async {
    addBlog(
      Blog(
          id: 8888,
          title: 'Erster Blog',
          content: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          likes: 22,
          comments: 0,
          author: 'user@hftm.ch',
          publishedAt: DateTime(2023, 5, 26)  // Jahr, Monat, Tag
      ),
    );
    addBlog(
      Blog(id: 8889,
          title: 'Zweiter Bloooooooooooooooooooog',
          content: 'Das ist der Vorschau.. wuhuuu... Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          likes: 200,
          comments: 3,
          author: 'user@hftm.ch',
          publishedAt: DateTime(2023, 2, 30)
      ),
    );
    addBlog(
      Blog(id: 8890,
          title: 'Dritter Bloooooooooooooooooooog',
          content: 'Das ist der Vorschau.. wuhuuu... Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          likes: 54,
          comments: 2,
          author: 'admin@hftm.ch',
          publishedAt: DateTime.now().subtract(const Duration(days: 2))
      ),
    );
    _isInitialized = true;
  }

  Future<List<Blog>> getBlogs() async {
    print('getBlogs called');
    if (!_isInitialized) {
      _initializeBlogs();
    }

    await Future.delayed(const Duration(milliseconds: 500));

    return _blogs..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  Future<void> addBlog(Blog blog) async{
    blog.id = _nextId++;
    blog.likes = 0;
    blog.comments = 0;
    _blogs.add(blog);
  }

  Future<void> deleteBlog(Blog blog) async {
    _blogs.remove(blog);
  }

  Future<void> updateBlog({required int blogId, required String title, required String content}) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.title = title;
    blog.content = content;
  }
}