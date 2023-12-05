import 'package:blogapp/screens/home_screen.dart';
import 'package:blogapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloggy',
      // For Smartphone driven light/dark Mode
      // theme: lightMode,
      // darkTheme: darkMode,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomeScreen(title: 'Bloggy'),
    );
  }
}

