//AutomaticKeepAliveClientMixin让列表常驻内存
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/toast_util.dart';

//L:列表数据模型不能写死
//M：数据接口返回的模型
//T:为具体的widget
//因为是工具类 所以不能有业务代码  设置为了抽象类
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;

  bool loading = false;
  ScrollController scrollController = ScrollController(); //监听列表的滚动 上拉加载更多

  get contentChild; //抽象属性
  @override
  void initState() {
    super.initState();
    loadData();

    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels; //可滚动的最大距离- 当前已滚动距离

      print('dis:$dis' + "---   "+scrollController.position.maxScrollExtent.toString()+"---    "+scrollController.position.pixels.toString());

      //scrollController.position.maxScrollExtent !=0
      //fix: 当列表高度不满屏幕高度时不执行加载更多
      if (dis < 300 && !loading && scrollController.position.maxScrollExtent !=0) {
        //底部距离不足100时加载更多
        print('_loading:$loading');
        loadData(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            //crossAxisCount 列
            child: contentChild),
        onRefresh: loadData);
  }

  //获取对应页码的数据
  Future<M> getData(int pageIndex);

  //从MO中解析出list数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      print("上次加载还没完成...");
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print("currentIndex:"+currentIndex.toString());
    try {
      var result = await getData(currentIndex);
      setState(() {
        loading = false;
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        //延时1秒
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
