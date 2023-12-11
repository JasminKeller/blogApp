import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../services/blog_repository.dart';
import '../widget/blog_card_widget.dart';

class BlogHomeScreen extends StatelessWidget {
  BlogHomeScreen({
    super.key,
    required this.blogs,
  });

  final List<Blog> blogs;
  final BlogRepository blogRepository = BlogRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          blogRepository.getBlogs();
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: blogs!.length,
          itemBuilder: (context, index) {
            return BlogCardWidget(blog: blogs![index]);
          },
        ),
      ),
    );
  }
}
