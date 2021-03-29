import 'package:json_annotation/json_annotation.dart';

//TestMo2.g.dart将在我们运行生成命令后自动生成 小写
part 'test_mo2.g.dart';

@JsonSerializable()
class TestMo2 {
  //定义字段
  int code;
  String method;
  String requestPrams;

  TestMo2(this.code, this.method, this.requestPrams);
  //固定格式， 不同的类使用不同的mixin即可 报错不用管
  factory TestMo2.fromJson(Map<String, dynamic> json) => _$TestMo2FromJson(json);
  //固定格式
  Map<String,dynamic> toJson() => _$TestMo2ToJson(this);
}
//执行命令生成实体类
//flutter packages pub run build_runner build