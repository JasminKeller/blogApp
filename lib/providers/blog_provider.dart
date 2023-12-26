import 'dart:async';

import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../services/blog_api.dart';

enum BlogState { initial, loaded, error }

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;
  BlogState _state = BlogState.initial;
  List<Blog> _blogs = [];

  BlogState get state => _state;
  List<Blog> get blogs => _blogs;

  BlogProvider() {
    _startRefreshTimer();
    readBlogsWithLoadingState();
  }

  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 60), (timer) {
      print('RefreshTimer Triggered');
      readBlogs();
    });
  }

  Future<void> readBlogsWithLoadingState() async {
    try{
      isLoading = true;
      _blogs = await BlogApi.instance.fetchBlogs();
      _state = BlogState.loaded;
      notifyListeners();
      isLoading = false;
    } catch (e) {
      print(e);
      _state = BlogState.error;
    }
    notifyListeners();
  }

  Future<void> readBlogs({bool withNotifying = true}) async {
    try {
      _blogs = await BlogApi.instance.fetchBlogs();
      _state = BlogState.loaded;
    } catch (e) {
      print(e);
      _state = BlogState.error;
    }
    notifyListeners();
  }

  Future<void> toggleLikeInfo(String blogId) async {
    try {

      // Test Error of Snackbar
      // throw Exception('Ein simulierter Fehler ist aufgetreten.');

      final blogIndex = _blogs.indexWhere((blog) => blog.id == blogId);
      if (blogIndex != -1) {
        final blog = _blogs[blogIndex];
        blog.isLikedByMe = !blog.isLikedByMe;
        blog.likes += blog.isLikedByMe ? 1 : -1;

        // TODO: Implement updateBlogLikes  example: await BlogService.instance.updateBlogLikes(blog);

        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchAndSetBlogs() async {
    isLoading = true;
    try {
      BlogApi blogApi = BlogApi.instance;
      List<Blog> fetchedBlogs = (await blogApi.fetchBlogs());
      _blogs = fetchedBlogs;
      isLoading = false;
    } catch (error) {
      isLoading = false;
      rethrow;
    }
    notifyListeners();
  }

}