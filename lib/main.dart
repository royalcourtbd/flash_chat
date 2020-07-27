import 'package:flashchat/pages/chat_screen.dart';
import 'package:flashchat/pages/launcher_sreen.dart';
import 'package:flashchat/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LauncherScreen(),
      routes: {
        WelcomeScreen.route: (context) => WelcomeScreen(),
        ChatScreen.route: (context) => ChatScreen(),
        LauncherScreen.route: (context) => LauncherScreen(),
      },
    );
  }
}
