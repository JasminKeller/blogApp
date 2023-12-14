import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entity/blog_entity.dart';
import 'package:blogapp/widget/favorite_icon_widget.dart';

import '../providers/blog_provider.dart';
import '../services/blog_repository.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.blog.title;
    _contentController.text = widget.blog.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () async {
              if (_isEditing) {
                await BlogRepository.instance.updateBlog(
                  blogId: widget.blog.id,
                  title: _titleController.text,
                  content: _contentController.text,
                );
                Provider.of<BlogProvider>(context, listen: false).readBlogsWithLoadingState();
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                _isEditing
                    ? TextField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.headline6,
                  autofocus: true,
                )
                    : Text(
                  widget.blog.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                if (!_isEditing)
                  const SizedBox(height: 20),
                if (!_isEditing)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const Image(
                      image: AssetImage('lib/assets/katze.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                if (!_isEditing)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.blog.author),
                        FavoriteIconWidget(blogId: widget.blog.id),
                      ],
                    ),
                  ),
                const SizedBox(height: 15),
                _isEditing
                    ? TextField(
                  controller: _contentController,
                  maxLines: null,
                )
                    : Text(widget.blog.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

