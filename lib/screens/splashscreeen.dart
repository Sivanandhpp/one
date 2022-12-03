import 'package:flutter/material.dart';
import 'package:one/screens/dashboard.dart';
import 'package:one/functions/loadingscreen.dart';
import 'package:one/main.dart';
import 'package:one/screens/startscreen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: checkFirstSeen(),
      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == false) {
            return const StartPage();
          }
          return const DashBoard();
        } else {
          return const LoadingScreen();
        }
      },
    );
  }

  Future<bool> checkFirstSeen() async {
    bool _seen = (spInstance.getBool('seen') ?? false);

    if (_seen) {
      return true;
    } else {
      await spInstance.setBool('seen', true);
      return false;
    }
  }
}
