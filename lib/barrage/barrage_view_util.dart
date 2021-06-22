import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/barrage_mo.dart';

class BarrageViewUtil{

  //样式定义
  static barrageView(BarrageModel model){
    switch(model.type){
      case 1:
        return _barraegType1(model);
    }
    return Text(model.content,style: TextStyle(color: Colors.white),);
  }
}

_barraegType1(BarrageModel model) {
  return Center(
    child: Container(
      child: Text(model.content,style: TextStyle(color: Colors.deepOrangeAccent),),
      decoration:BoxDecoration(
          border:Border.all(color: Colors.white,),
          borderRadius: BorderRadius.circular(15)
      ),
    ),
  );
}