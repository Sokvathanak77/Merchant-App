class SlideModel {
  bool? success;
  List<Data>? data;

  SlideModel({this.success, this.data});

  SlideModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? tage;
  String? image;
  int? slideOrder;
  String? link;
  String? action;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.tage,
      this.image,
      this.slideOrder,
      this.link,
      this.action,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tage = json['tage'];
    image = json['image'];
    slideOrder = json['slide_order'];
    link = json['link'];
    action = json['action'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tage'] = this.tage;
    data['image'] = this.image;
    data['slide_order'] = this.slideOrder;
    data['link'] = this.link;
    data['action'] = this.action;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
