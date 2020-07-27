import 'package:flashchat/helper/authentication_service.dart';
import 'package:flashchat/helper/constant_kyes.dart';
import 'package:flashchat/helper/rounded_button.dart';
import 'package:flashchat/pages/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeScreen extends StatefulWidget {
  static final route = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _email, _password, errorMsg = '';
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String uid;
  AuthenticationService _service;
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _service = AuthenticationService();
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        showSpinner = true;
      });

      try {
        if (isLogin) {
          uid = await _service.login(_email, _password);
        } else {
          uid = await _service.signUp(_email, _password);
        }

        if (uid != null) {
          Navigator.pushReplacementNamed(context, ChatScreen.route);
        }
        setState(() {
          showSpinner = false;
        });
      } catch (error) {
        setState(() {
          showSpinner = false;
          errorMsg = error.message;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _service = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                    Text(
                      'Flash Chat',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextInputFormFieldDecoration.copyWith(
                      hintText: 'Enter Your Email'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter a Valid Email Address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(
                  height: 7.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kTextInputFormFieldDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter a Valid Password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 character';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  title: 'Login',
                  onPressed: _submit,
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  title: 'Register',
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                    _submit();
                  },
                ),
                Text(
                  errorMsg,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
