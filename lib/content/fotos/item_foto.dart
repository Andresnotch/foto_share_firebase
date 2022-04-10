import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';

class ItemFoto extends StatefulWidget {
  final Map<String, dynamic> nonPublicFData;
  ItemFoto({Key? key, required this.nonPublicFData}) : super(key: key);

  @override
  State<ItemFoto> createState() => _ItemFotoState();
}

class _ItemFotoState extends State<ItemFoto> {
  bool _switchValue = false;
  @override
  void initState() {
    _switchValue = widget.nonPublicFData["public"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.nonPublicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _switchValue ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  _switchValue = !_switchValue;
                  setState(() {});
                },
              ),
              title: Text("${widget.nonPublicFData["title"]}"),
              subtitle:
                  Text("${widget.nonPublicFData["publishedAt"].toDate()}"),
              trailing: IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  _sharePhoto();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sharePhoto() async {
    String? image;
    var path;
    try {
      image = await ImageDownloader.downloadImage(
        "${widget.nonPublicFData["picture"]}",
        destination: AndroidDestinationType.custom(directory: 'downloads')
          ..inExternalFilesDir(),
      );
      if (image == null) {
        return;
      }
      path = await ImageDownloader.findPath(image);
    } catch (error) {
      print(error);
    }
    Share.shareFiles([path],
        subject: "${widget.nonPublicFData["title"]}",
        text: "${widget.nonPublicFData["publishedAt"].toDate()}");
  }
}
