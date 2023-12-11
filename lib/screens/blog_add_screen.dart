import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/blog_entity.dart';
import '../providers/blog_provider.dart';
import '../services/blog_repository.dart';

class BlogAddScreen extends StatefulWidget {
  const BlogAddScreen({super.key});

  @override
  _BlogAddScreenState createState() => _BlogAddScreenState();
}

enum _PageStates { loading, editing, done }

class _BlogAddScreenState extends State<BlogAddScreen> {
  final formKey = GlobalKey<FormState>();
  var pageStates = _PageStates.editing;
  var title = '';
  var content = '';
  var author = 'Test User';

  Future<void> _createBlog() async {
    var blogProvider = context.read<BlogProvider>();
    await Future.delayed(const Duration(seconds: 1));
    await BlogRepository.instance.addBlog(Blog(
      title: title,
      content: content,
      author: author,
      publishedAt: DateTime.now(),
    ));
    blogProvider.readBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
      ),
      body: Builder(builder: (context) {
        switch (pageStates) {
          case _PageStates.loading:
            return const Center(child: CircularProgressIndicator());
          case _PageStates.done:
            return Center(child: Text("Blog '$title' created!"));
          case _PageStates.editing:
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return "Please enter title with 4 or more characters";
                        }
                        return null;
                      },
                      onSaved: (value) => title = value!,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: "Content",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return "Please enter content with 10 or more characters";
                        }
                        return null;
                      },
                      onSaved: (value) => content = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Hide keyboard
                        FocusScope.of(context).unfocus();

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            pageStates = _PageStates.loading;
                          });
                          formKey.currentState!.save();
                          await _createBlog();
                          setState(() {
                            pageStates = _PageStates.done;
                          });
                        }
                      },
                      child: const Text("Save"),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
        }
        return const Center(child: Text('Unknown state'));
      }),
    );
  }
}
