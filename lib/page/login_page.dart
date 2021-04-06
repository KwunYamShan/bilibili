import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/login_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/page/login_button.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const LoginPage({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName;
  String password;
  String rePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        "立即登陆",
        "注册",
        widget.onJumpToLogin,
      ),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (text) {
                userName = text;
                _checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              onChanged: (text) {
                password = text;
                _checkInput();
              },
              obscureText: true,
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return LoginButton(title:'登陆',enable:loginEnable ,onPressed:(){
      send();
    });
  }

  void send() async{
    try{
      var result = await LoginApi.login(userName, password);
      print(result);
      if(result['code'] == 0 ){
        print('登陆成功');
        if(widget.onJumpToLogin !=null){
          widget.onJumpToLogin();
        }
       setState(() {
         showToast('登陆成功');
       });
      }else{
        print(result['msg']);
      }
    }on NeedLogin catch(e){
      print(e);
    }on NeedAuth catch(e){
      print(e);
    }
  }


  void _checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }
}
