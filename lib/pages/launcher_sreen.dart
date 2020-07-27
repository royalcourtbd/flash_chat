import 'package:flashchat/helper/authentication_service.dart';
import 'package:flashchat/pages/chat_screen.dart';
import 'package:flashchat/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatefulWidget {
  static final route = 'launcher_screen';
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  AuthenticationService _authenticationService;

  @override
  void initState() {
    super.initState();
    _authenticationService = AuthenticationService();
    _authenticationService.user.then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.route);
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('launcher'),
      ),
    );
  }
}
