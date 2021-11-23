import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

///带lottie动画的加载进度组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key? key, this.isLoading = false , this.cover = false,required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        //可叠加的widget
        children: [child, isLoading ? _loadingView : Container()],
      );
    } else {
      return isLoading ? _loadingView : child;
    }
  }

  //lottie动画
  Widget get _loadingView {
    return Container(
        alignment: Alignment.center,
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(15),
            //阴影
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 5,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: Lottie.asset('assets/loading.json'),
              ),
            ),
          ),
    );
  }
}
