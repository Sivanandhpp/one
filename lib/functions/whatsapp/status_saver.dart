import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:one/functions/whatsapp/viewstatusphoto.dart';
import 'package:one/functions/whatsapp/videogridwidget.dart';
import 'package:one/models/themecolor.dart';

final Directory _videoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
//if android version 11 or above
final Directory _newVideoDir = Directory(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

class StatusSaver extends StatefulWidget {
  const StatusSaver({super.key});

  @override
  State<StatusSaver> createState() => _StatusSaverState();
}

class _StatusSaverState extends State<StatusSaver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_videoDir.path).existsSync()) {
      return Scaffold(
        backgroundColor: ThemeColor.scaffoldBgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                  height: 100,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: const [
                      Text(
                        "Oops...WhatsApp not found!",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Install WhatsApp\nAvailable videos will be shown here",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (!Directory(_newVideoDir.path).existsSync()) {
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
                      'Whatsapp Status',
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
                  height: 20,
                ),
                DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: Column(
                    children: [
                      SegmentedTabControl(
                        controller: _tabController,
                        height: 30,
                        radius: const Radius.circular(10),
                        backgroundColor: ThemeColor.lightGrey,
                        indicatorColor: ThemeColor.primary,
                        tabTextColor: ThemeColor.black,
                        selectedTabTextColor: ThemeColor.white,
                        tabs: const [
                          SegmentTab(
                            label: "Videos",
                          ),
                          SegmentTab(
                            label: "Photos",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Expanded(child: VideoGridWidget(directory: _videoDir)),
                      Expanded(child: ViewStatusPhoto()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
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
                      'Whatsapp Status',
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
                  height: 30,
                ),
                Expanded(child: VideoGridWidget(directory: _newVideoDir))
              ],
            ),
          ),
        ),
      );
    }
  }
}
