//登陆动效
import 'dart:ui';

import 'package:flutter/material.dart';

//可爱的蒙眼小人
class LoginEffect extends StatefulWidget {
  final bool protect; //是否是保护类型

  LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右顶边 中间平均分配,
        children: [
          _image(true),
          Image(
            image: AssetImage('images/logo.png'),
            height: 90,
            width: 90,
          ),
          _image(false),
        ],
      ),
    );
  }

  _image(bool isLeft) {
    var headLeft = widget.protect
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect
        ? 'images/head_right_protect.png'
        : "images/head_right.png";
    return Image(
      height: 90,
      image: AssetImage(isLeft ? headLeft : headRight),
    );
  }
}
