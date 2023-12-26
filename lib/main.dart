import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Importiere foundation.dart für kDebugMode
import 'package:provider/provider.dart';
import 'package:blogapp/providers/blog_provider.dart';
import 'package:blogapp/providers/theme_provider.dart';
import 'package:blogapp/screens/home_screen.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    } else {
      return const Center(
        child: Text(
          "An error occurred.",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
          ),
        ),
      );
    }
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => BlogProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloggy',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomeScreen(title: 'Bloggy'),
    );
  }
}
