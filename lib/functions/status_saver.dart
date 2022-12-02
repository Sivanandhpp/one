import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:one/models/themecolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final Directory _videoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class StatusSaver extends StatefulWidget {
  const StatusSaver({super.key});

  @override
  State<StatusSaver> createState() => _StatusSaverState();
}

class _StatusSaverState extends State<StatusSaver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_videoDir.path).existsSync()) {
      return const Scaffold(
        backgroundColor: ThemeColor.scaffoldBgColor,
        body: SafeArea(
          child: Center(
            child: Text(
              "Install WhatsApp\nYour Friend's Status will be available here.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: ThemeColor.scaffoldBgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
                Expanded(child: VideoGridWidget(directory: _videoDir))
              ],
            ),
          ),
        ),
      );
    }
  }
}

class VideoGridWidget extends StatefulWidget {
  const VideoGridWidget({super.key, required this.directory});

  final Directory directory;

  @override
  State<VideoGridWidget> createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  _getImage(videoPathUrl) async {
    String? thumb = await VideoThumbnail.thumbnailFile(
        video: videoPathUrl, imageFormat: ImageFormat.WEBP, quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);
    if (videoList.length > 0) {
      return GridView.builder(
        itemCount: videoList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            crossAxisCount: (Orientation == Orientation.portrait) ? 1 : 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayStatusVideo(videoList[index]),
                ),
              ),
              child: FutureBuilder(
                future: _getImage(videoList[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Hero(
                        tag: videoList[index],
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              width: size.width,
                              height: 160,
                              child: Image.file(
                                File(
                                  snapshot.data.toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                size: 50,
                                Icons.play_circle_outline_rounded,
                                color: ThemeColor.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('fuck');
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: const Text(
            "Sorry, No Videos Found.",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }
}

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
    print("here is what you looking for:" + widget.videoFile);
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
                          const Text("FileManager > Downloaded Status",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            color: Colors.teal,
                            textColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: <Widget>[
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
            Container(
              color: ThemeColor.lightBlue,
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: TextButton.icon(
                icon: const Icon(
                  Icons.file_download,
                  color: ThemeColor.white,
                ),
                label: const Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: ThemeColor.white,
                  ),
                ), //`Text` to display
                onPressed: () async {
                  _onLoading(true, "");

                  File originalVideoFile = File(widget.videoFile);
                  Directory? directory = await getExternalStorageDirectory();
                  if (!Directory("${directory?.path}/Downloaded Status/Videos")
                      .existsSync()) {
                    Directory("${directory?.path}/Downloaded Status/Videos")
                        .createSync(recursive: true);
                  }
                  String? path = directory?.path;
                  String curDate = DateTime.now().toString();
                  String newFileName =
                      "$path/Downloaded Status/Videos/VIDEO-$curDate.mp4";
                  print(newFileName);
                  await originalVideoFile.copy(newFileName);

                  _onLoading(false,
                      "If Video not available in gallary\n\nYou can find all videos at");
                },
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
