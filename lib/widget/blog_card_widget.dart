import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';
import 'icon_with_counter_widget.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(blog.title),
              subtitle: Text(blog.contentPreview),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(blog.author),
                  Row(
                    children: [
                      IconWithCounterWidget(icon: Icons.favorite, count: blog.likes),
                      const SizedBox(width: 12),
                      IconWithCounterWidget(icon: Icons.mode_comment, count: blog.comments)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


