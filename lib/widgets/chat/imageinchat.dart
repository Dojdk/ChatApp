import 'package:flutter/material.dart';

import 'showimage.dart';

class ImageInChat extends StatelessWidget {
  final String url;
  final bool isMe;
  final Key keyimage;
  const ImageInChat({Key? key, required this.url, required this.isMe, required this.keyimage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: keyimage,
      mainAxisAlignment: isMe? MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Hero(
          tag: url,
          child: GestureDetector(
            onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ShowImage(url: url),)),
            child: SizedBox(
              height: 200,
              // width: 200
              child: Image.network(url),
            ),
          ),
        ),
        const SizedBox(width: 8,),
      ],
    );
  }
}