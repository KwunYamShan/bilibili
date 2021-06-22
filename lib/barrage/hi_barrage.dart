import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/barrage/barrage_item.dart';
import 'package:flutter_bilibili/barrage/hi_socket.dart';
import 'package:flutter_bilibili/barrage/ibarrage.dart';
import 'package:flutter_bilibili/model/barrage_mo.dart';

enum BarrageStatus {
  PLAY,
  PAUSE,
}

//弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  const HiBarrage(
      {Key key,
      this.lineCount = 4,
      @required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

 class HiBarrageState extends State<HiBarrage> with IBarrage {
  HiSocket _hiSocket;
  double _width;
  double _height;
  List<BarrageItem> _barrageItemList = []; //弹幕widget集合
  List<BarrageModel> _barrageModelList = []; //弹幕类型
  int _barrageIndex = 0; //第几条弹幕
  Random _random = Random();
  BarrageStatus _barrageStatus;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handlerMessage(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width/16*9;

    //限制孩子控件的大小
    return SizedBox(
      width: _width,
      height: _height,
      //可叠加的widget
      child: Stack(
        children: [
          //防止Stack的child为空
          Container()
        ]..addAll(_barrageItemList),
      ),
    );
  }

  @override
  void dispose() {
    if (_hiSocket != null) {
      _hiSocket.close();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  ///处理消息，instant=true。 马上发送
  void _handlerMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, modelList);
    } else {
      _barrageModelList.addAll(modelList);
    }
    //收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.PLAY) {
      play();
      return;
    }
    //收到新的弹幕后自动播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.PAUSE) {
      play();
    }
  }

  void addBarrage(BarrageModel temp) {


  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.PAUSE;
    _barrageModelList.clear(); //清空屏幕上的弹幕
    setState(() {
      //刷新屏幕
    });
    print("HiBarrage : pause: ");
    _timer.cancel();
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.PLAY;
    print("HiBarrage :play: ");
    if (_timer != null && _timer.isActive) return;
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        //将发送的弹幕从集合中剔除
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("HiBarrage :play: barrage :${temp.content}");
      }
    });
  }

  @override
  void send(String message) {
    if (message == null) return;
    _hiSocket.send(message);
    _handlerMessage([
      BarrageModel(content: message, vid: widget.vid, priority: 1, type: 1)
    ]);
  }
}
