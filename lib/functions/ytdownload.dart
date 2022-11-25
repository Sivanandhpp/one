import 'package:one/models/themecolor.dart';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YtDownload extends StatefulWidget {
  YtDownload({Key? key}) : super(key: key);

  @override
  State<YtDownload> createState() => _YtDownloadState();
}

class _YtDownloadState extends State<YtDownload> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var yt = YoutubeExplode();

  List ytInfo = ['null'];
  final TextEditingController ytController = TextEditingController();

  getYtInfo() async {
    var video = await yt.videos.get(ytController.text);

    var title = video.title;
    var author = video.author;
    var duration = video.duration;

    ytInfo = [title, author, duration];

    return ytInfo;
  }

  // getYtVideo() {

  // }
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
                    'YouTube',
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
                      child: TextField(
                        controller: ytController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "YouTube Link",
                            labelStyle: TextStyle(color: ThemeColor.grey)),
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
                          color: ThemeColor.ytRed,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(17),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        ytInfo[0] = 'loading...';
                      });

                      // ytInfo = YTC.getYtInfo();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: getYtInfo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(ytInfo[0]);
                    } else {
                      return Center(
                          child: (ytInfo[0] == 'loading...')
                              ? const CircularProgressIndicator()
                              : const Text("Paste a Youtube link"));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
