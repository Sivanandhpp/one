import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:one/models/themecolor.dart';
import 'package:torch_controller/torch_controller.dart';

class StrobeLight extends StatefulWidget {
  const StrobeLight({super.key});

  @override
  State<StrobeLight> createState() => _StrobeLightState();
}

class _StrobeLightState extends State<StrobeLight> {
  final torchController = TorchController();
  double strobeSpeed = 1.0;
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Strobe Light',
                    style: TextStyle(
                      color: ThemeColor.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: ThemeColor.lightGrey,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SleekCircularSlider(
                  initialValue: 1.0,
                  min: 0.1,
                  max: 10.0,
                  innerWidget: (percentage) => Center(
                        child: Text(
                          strobeSpeed.toString(),
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                  appearance: CircularSliderAppearance(
                      size: 250.0,
                      customColors: CustomSliderColors(
                          dynamicGradient: false,
                          trackColor: ThemeColor.lightGrey,
                          hideShadow: true,
                          progressBarColor: ThemeColor.primary)),
                  onChange: (double value) {
                    strobeSpeed = double.parse(value.toStringAsFixed(1));
                  }),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                color: ThemeColor.primary,
                onPressed: () async {
                  if (isOn) {
                    torchController.toggle();
                    isOn = false;
                  } else {
                    double temp = strobeSpeed * 1000;
                    int speedInMillisecond = temp.toInt();

                    for (int i = 0; i < 10; i++) {
                      torchController.toggle();
                      isOn = isOn ? false : true;

                      await Future.delayed(
                          Duration(milliseconds: speedInMillisecond), () {});
                    }
                  }
                },
                child: const Text(
                  'Toggle flash',
                  style: TextStyle(color: ThemeColor.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
