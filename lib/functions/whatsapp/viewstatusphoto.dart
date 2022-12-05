import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:one/functions/whatsapp/viewphoto.dart';
import 'package:one/models/themecolor.dart';

final Directory _photoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
final Directory _newPhotoDir =
    Directory(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

class ViewStatusPhoto extends StatefulWidget {
  const ViewStatusPhoto({super.key});

  @override
  ViewStatusPhotoState createState() {
    return ViewStatusPhotoState();
  }
}

class ViewStatusPhotoState extends State<ViewStatusPhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_photoDir.path).existsSync()) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: const Center(
            child: Text(
              "Install WhatsApp\nYour Friend's Status will be available here.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else if(!Directory(_newPhotoDir.path).existsSync()) {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg') || item.endsWith('.jpeg'))
          .toList(growable: false);

      if (imageList.isNotEmpty) {
        return Scaffold(
          backgroundColor: ThemeColor.scaffoldBgColor,
          body: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8.0),
            crossAxisCount: 4,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];
              return Material(
                elevation: 8.0,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ViewPhotos(imgPath)),
                  ),
                  child: Hero(
                    tag: imgPath,
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: const Text(
                "Sorry, No Images Found.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      }
    }else{
      var imageList = _newPhotoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg') || item.endsWith('.jpeg'))
          .toList(growable: false);

      if (imageList.isNotEmpty) {
        return Scaffold(
          backgroundColor: ThemeColor.scaffoldBgColor,
          body: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8.0),
            crossAxisCount: 4,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];
              return Material(
                elevation: 8.0,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ViewPhotos(imgPath)),
                  ),
                  child: Hero(
                    tag: imgPath,
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: const Text(
                "Sorry, No Images Found.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      }
    }
  }
}
