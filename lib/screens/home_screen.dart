import 'package:blogapp/services/blog_repository.dart';
import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../widget/blog_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final BlogRepository blogRepository = BlogRepository();

  List<Blog>? blogs;

  @override
  void initState() {
    super.initState();
    blogs = blogRepository.getBlogs();
  }

  
  @override
  Widget build(BuildContext context) {
    if (blogs==null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(blogs!.isEmpty){
      return const Center(
        child: Text('No blogs yet'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: blogs!.length,
          itemBuilder: (context, index) {
            return BlogCard(blog: blogs![index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Blog newBlog = Blog(title: 'Neu erstellter Blog', content: 'Inhalt des Neu erstellter Blog',contentPreview: 'ich bin die vorschau des Neu erstellter Blog', likes: 0, comments: 0, author: 'user@hftm.ch');
          blogRepository.addNewBlog(newBlog);
          setState(() {
            blogs = blogRepository.getBlogs();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
