
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color_util.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.title,required  this.enable, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable? onPressed:null,
        disabledColor: primary[50],
        color: primary,
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    );
  }
}
