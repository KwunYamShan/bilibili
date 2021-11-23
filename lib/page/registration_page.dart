import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/login_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/login_button.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {

  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  late String userName;
  late String password;
  late String rePassword;
  String imoocId = '7240673';
  String orderId = '2251';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登陆", (){HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
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
            LoginInput(
              title: "确认密码",
              hint: "请输入密码",
              onChanged: (text) {
                rePassword = text;
                _checkInput();
              },
              obscureText: true,
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              title: "慕课网ID",
              hint: "请输入你的慕课网id",
              keboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                _checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = !focus;
                });
              },
            ),
            LoginInput(
              title: "课程订单号",
              hint: "请输入课程订单号后四位",
              lineStretch: true,
              keboardType: TextInputType.number,
              onChanged: (text) {
                orderId = text;
                _checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = !focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(title:'注册',enable: loginEnable,onPressed: checkParams,),
            )
          ],
        ),
      ),
    );
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    }else{
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if(loginEnable){
          checkParams();
        }else{
          print('_loginButton is false');
        }
      },
      child: Text('注册'),
    );
  }

  void send() async{
    try{
        var result = await LoginApi.registration(userName, password, imoocId, orderId);
        print(result);
        if(result['code'] == 0 ){
          print('注册成功');
         HiNavigator.getInstance().onJumpTo(RouteStatus.login);
        }else{
          print(result['msg']);
        }
    }on NeedLogin catch(e){
        print(e);
    }on NeedAuth catch(e){
      print(e);
    }
  }
  void checkParams(){
    String? tips ;
    if(password !=rePassword){
      tips = '两次密码不一致';
    }else if(orderId.length !=4){
      tips = '请输入订单号的后四位';
    }
    if(tips !=null){
      print(tips);
      showWarnToast(tips);
      return;
    }
    send();
  }
}
