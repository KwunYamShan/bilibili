import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/profile_mo.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/hi_blur.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
class BenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;

  const BenefitCard({Key? key, required this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          _buildBenefit(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "增值服务",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "购买后登录慕课网再次点击打开查看",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  _buildCard(BuildContext context, Benefit mo, double width) {
    return InkWell(
      onTap: () {
        //HiNavigator.getInstance().openH5(mo.url);
        if(mo.name=="交流群"){
          FlutterClipboard.copy(mo.url).then(( value ) =>
              Fluttertoast.showToast(
                  msg: mo.url+"群号复制成功",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white));
          }else{
          _launchInBrowser(mo.url);
        }
        },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            child: Stack(
              children: [
                Positioned(child: HiBlur()),
                Positioned(
                    child: Center(
                  child: Text(
                    mo.name,
                    style: TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  //
  _buildBenefit(BuildContext context) {
    //计算卡片宽度
    var width = (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;

    return Row(
      children: [
        ...benefitList.map((mo) => _buildCard(context, mo, width)).toList()
      ],
    );
  }
}
