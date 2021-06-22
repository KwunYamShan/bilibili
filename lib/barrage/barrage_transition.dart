import 'package:flutter/material.dart';

//弹幕移动动效组件
class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;//播放完成的回调

  const BarrageTransition({Key key,@required this.duration,@required this.onComplete, @required this.child}) : super(key: key);
  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController = AnimationController(duration :widget.duration,vsync: this)
      //级联表达式
      ..addStatusListener((status) {
        //动画执行完毕之后的回调
      if(status == AnimationStatus.completed){
        widget.onComplete('');
      }
    });
    //定义从右到左的补间动画
    var begin = Offset(1.0, 0);//起始
    var end = Offset(-1.0, 0);//结束
    _animation = Tween(begin: begin,end: end).animate(_animationController);
    _animationController.forward();//开始动画
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
    child: widget.child,);
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
