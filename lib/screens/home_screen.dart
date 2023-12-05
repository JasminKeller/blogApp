import 'package:blogapp/screens/blogadd_screen.dart';
import 'package:blogapp/screens/settings_screen.dart';
import 'package:blogapp/services/blog_repository.dart';
import 'package:blogapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/blog_entity.dart';
import '../theme/theme.dart';
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

    //  light and darkmode icon change
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeData == darkMode;


    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;  // nur wenn man auf dem Homescreen ist darf mit dem zurück button auf andoid die app geschlossen werden.
        } else {
          return false;  // verhindert schliessen der App wenn man nicht auf dem HomeScreen ist
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
         actions: [
           IconButton(
             icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
             onPressed: () {
               Provider.of<ThemeProvider>(context, listen:false).toggleTheme();
             },
           )
         ],
        ),
        body: _screens[_selectedIndex],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Text('Menu')),
              ListTile(
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: (){
                  _navigationBottomBar(0);
                  Navigator.pop(context);
                }
              ),
              ListTile(
                  title: const Text('Add New Blog'),
                  selected: _selectedIndex == 1,
                  onTap: (){
                    _navigationBottomBar(1);
                    Navigator.pop(context);
                  }
              ),
              ListTile(
                  title: const Text('Settings'),
                  selected: _selectedIndex == 2,
                  onTap: (){
                    _navigationBottomBar(2);
                    Navigator.pop(context);
                  }
              )
            ],
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
      ),
    );
  }
}


