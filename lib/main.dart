import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one/screens/dashboard.dart';
import 'package:one/screens/splashscreeen.dart';
import 'package:one/screens/startscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torch_controller/torch_controller.dart';

late SharedPreferences spInstance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TorchController().initialize();
  spInstance = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'One',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
