import 'package:chewie/chewie.dart' hide MaterialControls; //隐藏该包中的MaterialControls类
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import 'hi_video_controls.dart';

///播放器组件
class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;
  final Widget? barrageUI;

  const VideoView(this.url,
      {Key? key,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI,
      this.barrageUI})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_player 播放器 controller
  late ChewieController _chewieController; //chewie 播放器controller
  get _placeholder => FractionallySizedBox(
        //封面
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );

  //进度条颜色配置
  get _progressColors => ChewieProgressColors(
        playedColor: primary, //播放状态下的颜色
        handleColor: primary, //拖动状态下的颜色
        backgroundColor: Colors.grey, //背景色
        bufferedColor: primary[50]!, //缓冲状态的颜色
      );

  @override
  void initState() {
    super.initState();
    //初始化播放器设置
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      //比例
      autoPlay: widget.autoPlay,
      //自动播放
      looping: widget.looping,
      //循环播放
      allowMuting: false,
      //是否允许静音
      allowPlaybackSpeedChanging: false,
      //播放速度
      placeholder: _placeholder,
      customControls: HiVideoControls(
        showLoadingOnInitialize: false, //初始化加载进度
        showBigPlayIcon: false, //是否显示大播放按钮
        bottomGradient: blackLinearGradient(), //设置底部线性渐变
        overlayUI: widget.overlayUI,
        barrageUI: widget.barrageUI,
      ),
      materialProgressColors: _progressColors, //设置进度条颜色
    );
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //屏幕宽
    double playerHeight = screenWidth / widget.aspectRatio;

    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  //全屏幕切换的监听
  _fullScreenListener() {
    Size size = MediaQuery.of(
      context,
    ).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
