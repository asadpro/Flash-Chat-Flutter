import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_messenger/constants.dart';
import 'package:flash_chat_messenger/screens/chat_screen.dart';
import 'package:flash_chat_messenger/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = 'logScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final List? args = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            Buttons(
              alignmentTween: args![0],
              borderShape: args[1],
              btnText: 'Log In',
              onPress: () async {
                try {
                  final checkUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  print(e);
                }
              },
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
