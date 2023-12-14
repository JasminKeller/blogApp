import 'dart:async';

import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../services/blog_repository.dart';

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Blog> _blogs = [];

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
    isLoading = true;
    notifyListeners();
    await readBlogs(withNotifying: false);
    isLoading = false;
    notifyListeners();
  }

  Future<void> readBlogs({bool withNotifying = true}) async {
    _blogs = await BlogRepository.instance.getBlogs();
    if (withNotifying) {
      notifyListeners();
    }
  }

  Future<void> toggleLikeInfo(int blogId) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.isLikedByMe = !blog.isLikedByMe;
    blog.likes += blog.isLikedByMe ? 1 : -1;

    await readBlogsWithLoadingState();
  }

}