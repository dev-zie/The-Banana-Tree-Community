import 'package:flutter/material.dart';
import 'package:the_banana_tree_community/presentation/pages/welcomePage/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const WelcomeView(),
    );
  }
}
