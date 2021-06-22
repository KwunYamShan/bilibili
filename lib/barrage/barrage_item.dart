import 'package:flutter/material.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;//播放完成
  final Duration duration;//弹幕从左到右滚动时长

  const BarrageItem({Key key, this.id, this.top, this.onComplete, this.duration = const Duration(seconds:9  ), this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
