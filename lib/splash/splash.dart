import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import '../src/login/login.dart';


// https://www.youtube.com/watch?v=HQ_ytw58tC4

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    String bgImageUrl = "/images/backgrounds/bg.png";

    return FlutterSplashScreen.fadeIn(
      duration: const Duration(milliseconds: 5515),
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("/images/fsa_logo.png", width: 100, height: 100,),
              ),
              const Text('FSA Report', style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 59, 59, 59), fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const Login(),
    );
  }
}
