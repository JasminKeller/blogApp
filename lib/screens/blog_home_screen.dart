import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogapp/providers/blog_provider.dart';
import 'package:blogapp/widget/blog_card_widget.dart';
import 'package:blogapp/providers/theme_provider.dart';

import '../theme/theme.dart';

class BlogHomeScreen extends StatelessWidget {
  BlogHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var blogProvider = Provider.of<BlogProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeData == darkMode;

    if (blogProvider.blogs.isEmpty) {
      blogProvider.fetchAndSetBlogs();
    }

    if (blogProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloggy'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await blogProvider.readBlogsWithLoadingState();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: blogProvider.blogs.length,
          itemBuilder: (context, index) {
            return BlogCardWidget(blog: blogProvider.blogs[index]);
          },
        ),
      ),
    );
  }
}
