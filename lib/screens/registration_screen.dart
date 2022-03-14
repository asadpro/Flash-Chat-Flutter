import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_messenger/constants.dart';
import 'package:flash_chat_messenger/screens/chat_screen.dart';
import 'package:flash_chat_messenger/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static String id = 'regScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Here instance is the static property of FirebaseAuth class that's why we access it without creating an object.
  final _auth = FirebaseAuth.instance;

  late String _email;
  late String _password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final List? args = ModalRoute.of(context)!.settings.arguments as List;
    return ProgressHUD(
      barrierEnabled: showSpinner,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                  onChanged: (value) => _email = value,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _password = value,
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              Buttons(
                  alignmentTween: args![0],
                  borderShape: args[1],
                  btnText: 'Register',
                  color: Colors.blueAccent,
                  onPress: () async {
                    showSpinner = true;
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);

                      Navigator.pushNamed(context, ChatScreen.id);
                      _email = '';
                      _password = '';
                      setState(() {});
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
