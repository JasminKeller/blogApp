import 'package:blogapp/widget/favorite_icon_widget.dart';
import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Image(image: AssetImage('lib/assets/katze.jpg')),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(blog.author),
                      FavoriteIconWidget(blogId: blog.id),
                    ],
                  ),
                ),
                Text(blog.content)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
