class Owner {
  late String name;
  late String face;
  late int fans;

  Owner({required this.name,required  this.face,required  this.fans});

  //将map转为mo
  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  //将mo转为map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    return data;
  }

  static var ownerMap = {
    "name": "园林风",
    "face":
        "https://img2.sycdn.imooc.com/szimg/60497caf0971842912000676-360-202.png",
    "fans": 0
  };
}
