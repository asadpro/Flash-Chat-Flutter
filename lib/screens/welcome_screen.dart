import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_messenger/screens/login_screen.dart';
import 'package:flash_chat_messenger/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation borderAnimation;
  late Animation alignmentTween;
  late Animation borderShape;

  @override
  void initState() {
    super.initState();
    

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = ColorTween(
            begin: Colors.blue, end: Colors.green)
        .animate(controller);
    animation2 = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    borderAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(12), end: BorderRadius.circular(22))
        .animate(controller);
    alignmentTween =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.center)
            .animate(controller);

    borderShape = ShapeBorderTween(
      begin: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      end: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ).animate(controller);

    controller.forward();

    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward(from: 0.0);
    //   }
    // });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[300]!.withOpacity(controller.value),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                //Hero is an animation tag which flies this log from one screen onto another.
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: animation2.value * 160,
                  ),
                ),
                DefaultTextStyle(
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 2,
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons(
              alignmentTween: alignmentTween,
              borderShape: borderShape,
              btnText: 'Log In',
              onPress: () => Navigator.pushNamed(context, LoginScreen.id,
                  arguments: [alignmentTween, borderShape]),
              color: Colors.lightBlueAccent,
            ),
            Buttons(
              alignmentTween: alignmentTween,
              borderShape: borderShape,
              btnText: 'Register',
              color: Colors.blueAccent,
              onPress: () => Navigator.pushNamed(context, RegistrationScreen.id,
                  arguments: [alignmentTween, borderShape]),
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.alignmentTween,
    required this.borderShape,
    required this.btnText,
    required this.onPress,
    required this.color,
  }) : super(key: key);

  final Animation alignmentTween;
  final Animation borderShape;
  final String btnText;
  final VoidCallback onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: alignmentTween.value,
          primary: color,
          elevation: 5.0,
          shape: borderShape.value,
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: onPress,
        child: Text(
          btnText,
        ),
      ),
    );
  }
}
