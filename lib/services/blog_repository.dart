import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';

class BlogRepository {

  final List<Blog> _blogs = [
    Blog(title: 'Erster Blog', content: 'Inhalt des ersten Blogs',contentPreview: 'ich bin die vorschau', likes: 2, comments: 0, author: 'user@hftm.ch'),
    Blog(title: 'Zweiter Blog', content: 'Inhalt des Zweiter Blogs',contentPreview: 'ich bin die vorschau', likes: 2, comments: 0, author: 'user@hftm.ch'),
  ];

  List<Blog> getBlogs(){
    return List<Blog>.from(_blogs);
  }

  void addNewBlog(Blog blog){
    _blogs.add(blog);
  }
}