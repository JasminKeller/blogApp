import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/blog_entity.dart';
import '../providers/blog_provider.dart';


class FavoriteIconWidget extends StatelessWidget {
  final String blogId;

  const FavoriteIconWidget({
    Key? key,
    required this.blogId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var blogProvider = Provider.of<BlogProvider>(context, listen: true);
    bool blogExists = blogProvider.blogs.any((b) => b.id == blogId);
    if (!blogExists) {
      return Container(); // Todo: Placeholder in case blog does not exist
    }

    final Blog blog = blogProvider.blogs.firstWhere((b) => b.id == blogId);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: (blog.isLikedByMe
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border)),
          color: Colors.red[500],
          onPressed: () async {
            await blogProvider.toggleLikeInfo(blogId);
          },
        ),
        Text('${blog.likes}'),
      ],
    );
  }
}





