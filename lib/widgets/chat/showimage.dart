import 'package:flutter/material.dart';

import 'package:gallery_saver/gallery_saver.dart';

class ShowImage extends StatelessWidget {
  final String url;
  const ShowImage({Key? key, required this.url}) : super(key: key);

  Future<void> _saveimage()async{
    await GallerySaver.saveImage(url,albumName: 'ChatApp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Your Image'), actions: [
          IconButton(onPressed: _saveimage, icon: const Icon(Icons.download))
        ]),
        body: Center(
          child: Hero(
            tag: url,
            child: Image.network(url),
          ),
        ));
  }
}
