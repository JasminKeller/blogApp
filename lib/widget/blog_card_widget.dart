import 'package:blogapp/screens/blog_detail_screen.dart';
import 'package:blogapp/widget/comment_icon_widget.dart';
import 'package:flutter/material.dart';
import '../entity/blog_entity.dart';
import 'favorite_icon_widget.dart';
import 'icon_with_counter_widget.dart';

class BlogCardWidget extends StatefulWidget {
  final Blog blog;

  const BlogCardWidget({super.key, required this.blog});

  @override
  _BlogCardWidgetState createState() => _BlogCardWidgetState();
}

class _BlogCardWidgetState extends State<BlogCardWidget> {
  late bool _isLikedByMe;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _isLikedByMe = widget.blog.isLikedByMe;
    _likes = widget.blog.likes;
  }

  void _handleFavoriteChanged(bool isFavorited) {
    setState(() {
      _isLikedByMe = isFavorited;
      _likes = isFavorited ? _likes + 1 : _likes - 1;
      widget.blog.isLikedByMe = _isLikedByMe;
      widget.blog.likes = _likes;
    });
  }

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
              dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailPage(
                      title: widget.blog.title,
                      content: widget.blog.content,
                      author: widget.blog.author,
                      likes: widget.blog.likes,
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
                        favoriteCount: _likes,
                        isFavorited: _isLikedByMe,
                        onFavoriteChanged: _handleFavoriteChanged,
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
