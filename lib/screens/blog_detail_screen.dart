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

enum _PageStates { loading, ready }

class _BlogDetailPageState extends State<BlogDetailPage> {
  Blog? _updatedBlog;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isEditing = false;

  var pageState = _PageStates.ready;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.blog.title;
    _contentController.text = widget.blog.content;
  }

  bool _validateTitle() {
    return _titleController.text.length >= 4;
  }

  bool _validateContent() {
    return _contentController.text.length >= 10;
  }

  Future<void> _updateBlog() async {
    setState(() => pageState = _PageStates.loading);
    var blogProvider = Provider.of<BlogProvider>(context, listen: false);
    await BlogRepository.instance.updateBlog(
      blogProvider,
      blogId: widget.blog.id,
      title: _titleController.text,
      content: _contentController.text,
    );

    _updatedBlog = blogProvider.blogs.firstWhere((b) => b.id == widget.blog.id, orElse: () => widget.blog);
    setState(() => pageState = _PageStates.ready);
  }

  @override
  Widget build(BuildContext context) {
    final blogToShow = _updatedBlog ?? widget.blog;
    if (pageState == _PageStates.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
      } else {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                onPressed: () async {
                  if (_isEditing) {
                    if (!_validateTitle() || !_validateContent()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_validateTitle() ? 'Please enter content with 10 or more characters' : 'Please enter title with 4 or more characters'),
                        ),
                      );
                      return;
                    }
                    await _updateBlog();
                  }
                  setState(() => _isEditing = !_isEditing);
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
                    blogToShow.title,
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
                          Text(blogToShow.author),
                          FavoriteIconWidget(blogId: blogToShow.id),
                        ],
                      ),
                    ),
                  const SizedBox(height: 15),
                  _isEditing
                      ? TextField(
                    controller: _contentController,
                    maxLines: null,
                  )
                      : Text(blogToShow.content),
                ],
              ),
             ),
            ),
          ),
        );
       }
    }
  }

