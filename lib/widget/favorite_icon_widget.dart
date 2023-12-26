import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/blog_entity.dart';
import '../providers/blog_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final String blogId;

  const FavoriteIconWidget({
    Key? key,
    required this.blogId,
  }) : super(key: key);

  @override
  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  Widget build(BuildContext context) {
    var blogProvider = Provider.of<BlogProvider>(context, listen: true);
    bool blogExists = blogProvider.blogs.any((b) => b.id == widget.blogId);
    if (!blogExists) {
      return Container(); // Todo: Placeholder in case blog does not exist
    }

    final Blog blog = blogProvider.blogs.firstWhere((b) => b.id == widget.blogId);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: (blog.isLikedByMe
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border)),
          color: Colors.red[500],
          onPressed: () async {
            try {
              await blogProvider.toggleLikeInfo(widget.blogId);
            } catch (e) {
              // Verwenden von 'mounted' um zu überprüfen, ob das Widget noch im Widget-Baum ist.
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to toggle like info: $e'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            }
          },
        ),
        Text('${blog.likes}'),
      ],
    );
  }
}
