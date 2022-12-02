import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:one/functions/status_saver.dart';
import 'package:one/functions/strobelight.dart';
import 'package:one/functions/ytdownload.dart';
import 'package:one/models/themecolor.dart';
import 'package:open_whatsapp/open_whatsapp.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String? waNumber = "+91";

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
                    'Hey, there!',
                    style: TextStyle(
                      color: ThemeColor.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ThemeColor.lightGrey,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 1,
                        bottom: 1,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          waNumber = number.phoneNumber;
                        },
                        searchBoxDecoration: const InputDecoration(
                            prefixIcon: Icon(Icons.room_rounded),
                            label: Text("Search Country Code")),
                        selectorConfig: const SelectorConfig(
                          showFlags: true,
                          trailingSpace: false,
                          setSelectorButtonAsPrefixIcon: true,
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        inputDecoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "WhatsApp NO:",
                            hintStyle: TextStyle(color: ThemeColor.lightGrey)),
                        cursorColor: Colors.white,
                        textStyle: const TextStyle(
                            color: ThemeColor.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(
                            color: ThemeColor.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.waGreen,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(13),
                      child: const Icon(
                        Icons.whatsapp,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      FlutterOpenWhatsapp.sendSingleMessage(waNumber, "Hello");
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              //TODO:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //YOUTUBE VIDEO DOWNLOAD
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.ytRed,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YtDownload()));
                    },
                  ),

                  //STROBE LIGHT
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.orangeForLoc,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.flash_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StrobeLight()));
                    },
                  ),
                  //WHATSAPP STATUS SAVE
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.green,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusSaver(),
                          ));
                    },
                  ),
                  //
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                                offset: Offset(0, 10)),
                          ],
                          color: ThemeColor.primary,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.flash_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}






//dumping area

// InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => StrobeLight()));
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 145,
//                   decoration: BoxDecoration(
//                     boxShadow: const [
//                       BoxShadow(
//                           color: ThemeColor.lightGrey,
//                           blurRadius: 100,
//                           spreadRadius: 1,
//                           offset: Offset(0, 10)),
//                     ],
//                     color: ThemeColor.primary,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               )