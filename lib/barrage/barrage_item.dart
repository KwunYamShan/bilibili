import 'package:flutter/material.dart';
import 'package:flutter_bilibili/barrage/barrage_transition.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double? top;
  final Widget child;
  final ValueChanged onComplete; //播放完成
  final Duration duration; //弹幕从左到右滚动时长

  BarrageItem(
      {Key? key,
       required this.id,
       this.top,
       required this.onComplete,
        this.duration = const Duration(seconds: 9),
       required this.child})
      : super(key: key);

  //fix 动画状态错乱
  var _key = GlobalKey<BarrageTransitionState>();
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: top,
      child: BarrageTransition(key: _key,child: child,onComplete: (v){
        onComplete(id);
      },
      duration: duration,),);
  }
}
