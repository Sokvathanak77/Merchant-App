import 'package:get/get.dart';

class ApiCartModel {
  bool? success;
  List<ApiData>? data;
  int? amount;
  int? amountQty;

  ApiCartModel({this.success, this.data, this.amount});

  ApiCartModel.fromJson(dynamic json) {
    if(json == null){
      json={};
    }
    success = json['success'];
    if (json['data'] != null) {
      data = <ApiData>[];
      json['data'].forEach((v) {
        data!.add(new ApiData.fromJson(v));
      });
    }
    amount = json['amount'];
    amountQty = json['amount_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['amount_qty'] = this.amountQty;
    return data;
  }
}

class ApiData {
  int? id;
  int? userId;
  int? productId;
  double? qty;
  double? unitPrice;
  double? total;
  String? createdAt;
  String? updatedAt;
  ApiProducts? apiproducts;

  ApiData(
      {this.id,
      this.userId,
      this.productId,
      this.qty,
      this.unitPrice,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.apiproducts});

  ApiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    qty = json['qty'].toDouble();
    unitPrice = json['unit_price'].toDouble();
    total = json['total'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    apiproducts = json['products'] != null
        ? new ApiProducts.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.apiproducts != null) {
      data['products'] = this.apiproducts!.toJson();
    }
    return data;
  }
}

class ApiProducts {
  int? id;
  String? name;
  String? image;
  String? color;
  String? description;
  double? price;
  int? categoryId;
  String? ram;
  String? storage;
  int? buy;
  double? margin;
  int? stock;
  String? action;
  String? createdAt;
  String? updatedAt;

  ApiProducts(
      {this.id,
      this.name,
      this.image,
      this.color,
      this.description,
      this.price,
      this.categoryId,
      this.ram,
      this.storage,
      this.buy,
      this.margin,
      this.stock,
      this.action,
      this.createdAt,
      this.updatedAt});

  ApiProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    color = json['color'];
    description = json['description'];
    price = json['price'].toDouble();
    categoryId = json['category_id'];
    ram = json['ram'];
    storage = json['storage'];
    buy = json['buy'];
    margin = json['margin'].toDouble();
    stock = json['stock'];
    action = json['action'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['color'] = this.color;
    data['description'] = this.description;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['ram'] = this.ram;
    data['storage'] = this.storage;
    data['buy'] = this.buy;
    data['margin'] = this.margin;
    data['stock'] = this.stock;
    data['action'] = this.action;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
