import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../widget/blog_card_widget.dart';

class BlogHomeScreen extends StatelessWidget {
  const BlogHomeScreen({
    super.key,
    required this.blogs,
  });

  final List<Blog>? blogs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: blogs!.length,
        itemBuilder: (context, index) {
          return BlogCard(blog: blogs![index]);
        },
      ),
    );
  }
}
