import 'package:blogapp/screens/blogdetail_screen.dart';
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
              leading: const Image(image: AssetImage('lib/assets/katze.jpg')),
              title: Text(blog.title),
              subtitle: Text(blog.contentPreview),
              trailing: const Icon(Icons.navigate_next),
              dense: true,

              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlogDetailPage(
                      title: blog.title,
                      content: blog.content,
                      author: blog.author,
                      likes: blog.likes,
                    ))
                );
              },

              onLongPress: () {
                print('Looooooong pressed!');
              },
            ),
            //const Image(image: AssetImage('lib/assets/katze.jpg')),
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


