import 'package:blogapp/screens/blog_detail_screen.dart';
import 'package:blogapp/widget/comment_icon_widget.dart';
import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';
import 'favorite_icon_widget.dart';

class BlogCardWidget extends StatefulWidget {
  final Blog blog;

  const BlogCardWidget({super.key, required this.blog});

  @override
  _BlogCardWidgetState createState() => _BlogCardWidgetState();
}

class _BlogCardWidgetState extends State<BlogCardWidget> {

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
              title: Text(widget.blog.title),
              subtitle: Text(widget.blog.contentPreview),
              trailing: const Icon(Icons.navigate_next),
              // dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailPage(
                      blog: widget.blog,
                    ),
                  ),
                );
              },
              onLongPress: () {
                print('Looooooong pressed!');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.blog.author),
                  Row(
                    children: [
                      FavoriteIconWidget(
                          blogId: widget.blog.id
                      ),
                      CommentIconWidget(commentCount: widget.blog.comments),
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
