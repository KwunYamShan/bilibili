import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoMo;

  const VideoCard({Key key, this.videoMo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.network(videoMo.cover),
      onTap: (){
        print("VideoCard"+videoMo.url);
      },
    );
  }
}
