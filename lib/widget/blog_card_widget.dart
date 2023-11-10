import 'package:flutter/material.dart';
class BlogCard extends StatefulWidget {
  const BlogCard({super.key});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('Card Text'),
    );
  }
}
