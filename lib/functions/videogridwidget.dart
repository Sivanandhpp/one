
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/functions/playsatusvideo.dart';
import 'package:one/models/themecolor.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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