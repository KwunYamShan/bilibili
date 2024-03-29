import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/profile_mo.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/view_util.dart';

class CourseCard extends StatelessWidget {
  final List<Course> courseList;

  const CourseCard({Key? key, required this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          ..._buildCardList(context),
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
            "职场进阶",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "带你突破进阶瓶颈",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  //动态布局
  _buildCardList(BuildContext context) {
    var courseGroup = Map();
    //将课程分组
    courseList.forEach((mo) {
      if (!courseGroup.containsKey(mo.group)) {
        courseGroup[mo.group] = [];
      }
      List list = courseGroup[mo.group];
      list.add(mo);
    });
    return courseGroup.entries.map((e) {
      List list = e.value;
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
              list.length;
      var height = width / 16 * 6;
      return Row(
        children: [...list.map((mo) => _buildCard(mo, width, height)).toList()],
      );
    });
  }

  _buildCard(mo, double width, double height) {
    return InkWell(
      onTap: () {
        //HiNavigator.getInstance().openH5(mo.url);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5,bottom: 7),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: cachedImage(mo.cover, width: width, height: height),
    ),
      ),
    );
  }
}
