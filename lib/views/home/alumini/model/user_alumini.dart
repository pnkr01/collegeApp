class Alumini {
  String? name;
  String? title;
  String? desc;
  String? soe;
  String? eoe;
  String? imgUrl;
  Alumini({
    required this.name,
    required this.title,
    required this.desc,
    required this.soe,
    required this.eoe,
    required this.imgUrl,
  });

  Alumini.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    soe = json['soe'];
    eoe = json['eoe'];
    desc = json['desc'];
    imgUrl = json['imgurl'];
  }
}
