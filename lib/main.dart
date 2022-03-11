import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_messenger/screens/chat_screen.dart';
import 'package:flash_chat_messenger/screens/login_screen.dart';
import 'package:flash_chat_messenger/screens/registration_screen.dart';
import 'package:flash_chat_messenger/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),

      /*There are the static ids which can be accessed without creating an object of 
      class from scrach these id's works here as an identifier of a class to help us in routing. */
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
