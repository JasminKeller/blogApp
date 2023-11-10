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
  final List<Blog> blogs = [
    Blog(title: 'Erster Blog', content: 'Inhalt des ersten Blogs'),
    Blog(title: 'Zweiter Blog', content: 'Inhalt des zweiten Blogs'),
  ];

  void _addNewBlog(){
    setState(() {
      blogs.add(Blog(title: 'Neu erstellter Blog', content: 'Der Button funktionniert'));
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return BlogCard(blog: blogs[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBlog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
