import 'package:blogapp/screens/blogadd_screen.dart';
import 'package:blogapp/screens/settings_screen.dart';
import 'package:blogapp/services/blog_repository.dart';
import 'package:flutter/material.dart';

import '../entity/blog_entity.dart';
import '../widget/blog_card_widget.dart';
import 'bloghome_screen.dart';

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

  // BOTTOM NAV BAR https://www.youtube.com/watch?v=qk-a_Qgc6b0
  int _selectedIndex = 0;

  void _navigationBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
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

    final List<Widget> _screens = [
      BlogHomeScreen(blogs: blogs),BlogAddScreen(), SettingsScreen()
    ];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        // centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
       actions: [
         IconButton(
           icon: const Icon(Icons.settings),
           onPressed: () {
             Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const SettingsScreen())
             );
           },
         )
       ],
      ),
      body: _screens[_selectedIndex],
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _navigationBottomBar,
        items:  const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add New Blog'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}


