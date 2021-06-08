
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/view_util.dart';

//可动态改变位置的Header组件
//性能优化：局部刷新的应用@9-5刷新原理    setState尽量要在整个页面中调用，应该在局部widget中 节约内存开销
class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;

  const HiFlexibleHeader({Key key,@required this.name, @required this.face,@required this.controller}) : super(key: key);
  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;
  //滚动的范围
  static const MAX_OFFSET = 80;
  double _dyBottom = MAX_BOTTOM;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      print('offset:$offset');
      //算出padding变化0-1
      var dyOffset = (MAX_OFFSET -offset)/ MAX_OFFSET;
      print('dyOffset:$dyOffset');
      //根据dyOffset算出具体的变化的padding值
      var dy = dyOffset * (MAX_BOTTOM - MIN_BOTTOM);
      //临界值保护
      if(dy > (MAX_BOTTOM - MIN_BOTTOM)){
        dy = MAX_BOTTOM - MIN_BOTTOM;
      }else if(dy <0){
        dy = 0;
      }
      print('dy:$dy');
      setState(() {
        //算出真实的padding
        _dyBottom = MIN_BOTTOM +dy;
      });
      print("_HiFlexibleHeaderState initState _dyBottom:"+_dyBottom.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _dyBottom,left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face,width: 46,height: 46),
          ),
          hiSpace(width: 9),
          Text(widget.name,style: TextStyle(fontSize: 11,color: Colors.black54),)
        ],
      ),
    );
  }
}
