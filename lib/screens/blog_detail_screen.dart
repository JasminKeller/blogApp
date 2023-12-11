import 'package:flutter/material.dart';

import '../widget/icon_with_counter_widget.dart';

class BlogDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final int likes;

  const BlogDetailPage({super.key, required this.title, required this.content, required this.author, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                      Text(author),
                      IconWithCounterWidget(icon: Icons.favorite, count: likes),
                    ],
                  ),
                ),
                Text(content)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
