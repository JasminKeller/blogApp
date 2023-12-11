import 'dart:async';

import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../services/blog_repository.dart';

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  BlogProvider() {

  }

  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      readBlogs();
    });
  }

  Future<void> readBlogsWithLoadingState() async {
    isLoading = true;
    notifyListeners();     // Beobachter werden benachrichtigt das der Zustand geändert hat
    await readBlogs(withNotifying: false);
    isLoading = false;
    notifyListeners();    // Beobachter werden benachrichtigt das der Zustand geändert hat
  }

  Future<void> readBlogs({bool withNotifying = true}) async {
    _blogs = await BlogRepository.instance.getBlogs();
    if (withNotifying) {
      notifyListeners();
    }
  }




}