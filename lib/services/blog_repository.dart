import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';

class BlogRepository {

  final List<Blog> _blogs = [
    Blog(title: 'Erster Blog', content: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',contentPreview: 'ich bin die vorschau', likes: 2, comments: 0, author: 'user@hftm.ch'),
    Blog(title: 'Zweiter Bloooooooooooooooooooog', content: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',contentPreview: 'ich bin die vorschau', likes: 2, comments: 0, author: 'user@hftm.ch'),
  ];

  List<Blog> getBlogs(){
    return List<Blog>.from(_blogs);
  }

  void addNewBlog(Blog blog){
    _blogs.add(blog);
  }
}