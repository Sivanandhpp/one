
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:one/models/themecolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class PlayStatusVideo extends StatefulWidget {
  final String videoFile;

  PlayStatusVideo(this.videoFile);

  @override
  _PlayStatusVideoState createState() => _PlayStatusVideoState();
}

class _PlayStatusVideoState extends State<PlayStatusVideo> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Great, Saved in Gallary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: const TextStyle(
                                fontSize: 16.0,
                              )),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          const Text("FileManager > One > Whatsapp Status",
                              style: TextStyle(
                                  fontSize: 16.0, color: ThemeColor.primary)),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            color: ThemeColor.primary,
                            textColor: ThemeColor.white,
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Video Player',
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
            StatusVideo(
              videoPlayerController:
                  VideoPlayerController.file(File(widget.videoFile)),
              looping: true,
              videoSrc: widget.videoFile,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                _onLoading(true, "");

                File originalVideoFile = File(widget.videoFile);
                Directory? directory = await getExternalStorageDirectory();
                if (!Directory("/storage/emulated/0/one/Whatsapp Status")
                    .existsSync()) {
                  Directory("/storage/emulated/0/one/Whatsapp Status/")
                      .createSync(recursive: true);
                }
                // String? path = directory?.path;
                String curDate = DateTime.now().toString();
                String newFileName =
                    "/storage/emulated/0/one/Whatsapp Status/VIDEO-$curDate.mp4";
                print(newFileName);
                await originalVideoFile.copy(newFileName);

                _onLoading(false, "If video is not showing in gallary check");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ThemeColor.primary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.download,
                          color: ThemeColor.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Download",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: ThemeColor.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(widget.videoFile);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ThemeColor.primary),
                      child: const Icon(
                        Icons.share,
                        color: ThemeColor.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}



class StatusVideo extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoSrc;
  final double? aspectRatio;

  const StatusVideo({
    required this.videoPlayerController,
    required this.looping,
    required this.videoSrc,
    this.aspectRatio,
    Key? key,
  }) : super(key: key);

  @override
  _StatusVideoState createState() => _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        looping: widget.looping,
        autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AspectRatio(
        aspectRatio: 1,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
