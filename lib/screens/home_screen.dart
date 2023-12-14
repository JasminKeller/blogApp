import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogapp/screens/blog_add_screen.dart';
import 'package:blogapp/screens/settings_screen.dart';
import 'package:blogapp/screens/blog_home_screen.dart';
import 'package:blogapp/providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigationBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      BlogHomeScreen(),
      BlogAddScreen(),
      SettingsScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        return _selectedIndex == 0;
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _navigationBottomBar,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add New Blog'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
