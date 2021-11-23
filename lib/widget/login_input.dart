import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color_util.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged; //文字改变监听
  final ValueChanged<bool> ?focusChanged; //获取焦点监听
  final bool lineStretch; //分割线
  final bool obscureText; //密码保护
  final TextInputType? keboardType; //控制输入类型
  @override
  _LoginInputState createState() => _LoginInputState();

  LoginInput(
      {Key? key,
      required this.title,
      required this.hint,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keboardType})
      : super(key: key);
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); //判断输入框是否获取光标
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      print("Has focus ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          //下划线
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  //输入框
  _input() {
    //Expanded 填充剩余空间的控件
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keboardType,
      autofocus: !widget.obscureText,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      //输入框的样式
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        border: InputBorder.none,
        hintText: widget.hint ,
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
      ),
      cursorColor: primary,
    ));
  }
}
