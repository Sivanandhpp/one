import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:one/models/themecolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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

class _StatusSaverState extends State<StatusSaver> {
  @override
  void initState() {
    super.initState();
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
                    children: const [
                      SegmentedTabControl(
                        height: 30,
                        radius: Radius.circular(10),
                        backgroundColor: ThemeColor.lightGrey,
                        indicatorColor: ThemeColor.primary,
                        tabTextColor: ThemeColor.black,
                        selectedTabTextColor: ThemeColor.white,
                        tabs: [
                          SegmentTab(
                            label: "Videos",
                          ),
                          SegmentTab(
                            label: "Photos",
                          ),
                        ],
                      ),
                      // TabBarView(
                      //   physics: BouncingScrollPhysics(),
                      //   children: [
                      //     Center(child: CircularProgressIndicator()),
                      //     Center(child: CircularProgressIndicator())
                      //   ],
                      // ),
                    ],
                  ),
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
    if (videoList.isNotEmpty) {
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
                      return Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png');
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
                          const Text("FileManager > One > Whatsapp Status",
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
                  ), //TODO

                  GestureDetector(
                    onTap: () async {},
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
