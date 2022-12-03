import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:one/models/themecolor.dart';
import 'package:path_provider/path_provider.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  ViewPhotos(this.imgPath);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
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
                          const Text("FileManager > one > Whatsapp Status",
                              style: TextStyle(
                                  fontSize: 16.0, color: ThemeColor.primary)),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: const Text("Close"),
                            color: ThemeColor.primary,
                            textColor: ThemeColor.white,
                            onPressed: () => Navigator.pop(context),
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SizedBox.expand(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.imgPath,
                    child: Image.file(
                      File(widget.imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Photo Viewer',
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
                //Download button
                Positioned(
                  bottom: 50,
                  right: 30,
                  child: GestureDetector(
                    onTap: () async {
                      _onLoading(true, "");
                      File originalImageFile1 = File(widget.imgPath);

                      Directory? directory =
                          await getExternalStorageDirectory();
                      if (!Directory("/storage/emulated/0/one/Whatsapp Status/")
                          .existsSync()) {
                        Directory("/storage/emulated/0/one/Whatsapp Status/")
                            .createSync(recursive: true);
                      }
                      String? path = directory?.path;
                      String curDate = DateTime.now().toString();
                      String newFileName =
                          "/storage/emulated/0/one/Whatsapp Status/IMG-$curDate.jpg";

                      await originalImageFile1.copy(newFileName);

                      Uri myUri = Uri.parse(widget.imgPath);
                      File originalImageFile = File.fromUri(myUri);
                      Uint8List bytes;
                      await originalImageFile.readAsBytes().then((value) async {
                        bytes = Uint8List.fromList(value);

                        final result = await ImageGallerySaver.saveImage(
                            Uint8List.fromList(bytes));
                        print(result);
                      }).catchError((onError) {
                        print('Exception Error while reading audio from path:' +
                            onError.toString());
                      });
                      _onLoading(
                          false, "If image not showing in gallary check");
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
