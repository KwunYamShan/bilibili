import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/profile_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/profile_mo.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/benefit_card.dart';
import 'package:flutter_bilibili/widget/course_card.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/hi_blur.dart';
import 'package:flutter_bilibili/widget/hi_flexible_header.dart';

///我的
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin{
  ProfileMo _profileMo;

  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(//可滚动视图
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
           _buildAppBar(),
          ];
        },
        // body: ListView.builder(itemBuilder: (BuildContext context,int index){
        //   return ListTile(title: Text('标题$index'),);
        // },itemCount: 20,),
        body: ListView(//列表数量可控 所以直接用ListView
          padding: EdgeInsets.only(top: 10),
          children: [
            ..._buildContentList()
          ],
        )
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileMo result = await ProfileApi.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if(_profileMo == null) return Container();
    return HiFlexibleHeader(name: _profileMo.name, face: _profileMo.face, controller: _controller);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _buildAppBar() {
    return  SliverAppBar(
      //扩展高度
      expandedHeight: 160,
      //标题栏是否固定
      pinned: true,
      //定义滚动空间
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(child: cachedImage("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F11966562177%2F0.jpg&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625197578&t=cac329cdc052a2ead526a576a93a4be2"),
            ),
            Positioned.fill(child: HiBlur(sigma: 20,),),
            Positioned(bottom:0,left: 0,right: 0,child: _buildProfileTab())
          ],
        ),
      ),
    );
  }

  //用户资产tab下面的内容集合
  _buildContentList() {
    if(_profileMo == null){
      return [];
    }else{
      return [_buildBanner(),
        CourseCard(courseList:_profileMo.courseList),
        BenefitCard(benefitList: _profileMo.benefitList),
      ];
    }
  }

  //用户资产tab下面的banner
   _buildBanner() {
    return HiBanner(_profileMo.bannerList,bannerHeight: 120,padding: EdgeInsets.only(left: 10,right: 10),);
  }

  //头像下面 用户资产tab
  _buildProfileTab() {
    if(_profileMo == null){
      return Container();
    }
    return Container(
      padding:  EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText('收藏',_profileMo.favorite),
          _buildIconText('点赞',_profileMo.like),
          _buildIconText('浏览',_profileMo.browsing),
          _buildIconText('金币',_profileMo.coin),
          _buildIconText('粉丝',_profileMo.fans),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text('$count',style: TextStyle(fontSize: 15,color: Colors.black87),),
        Text(text,style: TextStyle(fontSize: 12,color: Colors.grey[600]),),
      ],
    );
  }

}

