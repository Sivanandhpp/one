import 'package:flutter/material.dart';
import 'package:one/screens/dashboard.dart';
import 'package:one/models/themecolor.dart';
import 'package:permission_handler/permission_handler.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final sSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                colors: [Color(0xFF00000), Color(0xFF00000)],
              ),
            ),
          ),
          const Center(
            child: Image(
              image: AssetImage('assets/illustration.png'),
              height: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'one!',
                      style: TextStyle(
                        color: ThemeColor.royalBlue,
                        fontSize: 60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "- the all in ONE solution",
                      style: TextStyle(
                          color: ThemeColor.royalBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Grand necessory permissions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ThemeColor.royalBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await Permission.storage.request();
                        await Permission.camera.request();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashBoard(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: sSize.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF1D2B64)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Get started",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: ThemeColor.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
