class ProductModel {
  bool? success;
  List<Data>? data;
  int? sumPage;
  int? totalPage;

  ProductModel({this.success, this.data, this.sumPage, this.totalPage});

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    sumPage = json['sum_page'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['sum_page'] = this.sumPage;
    data['total_page'] = this.totalPage;
    return data;
  }
}

class Data {
  int? id;
  int? productId;
  int? schemeId;
  int? unitPrice;
  int? margin;
  String? createdAt;
  String? updatedAt;
  Products? products;

  Data({
    this.id, 
    this.productId, 
    this.schemeId, 
    this.unitPrice,
    this.margin,
    this.createdAt,
    this.updatedAt, 
    this.products
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    schemeId = json['scheme_id'];
    unitPrice = json['unit_price'];
    margin = json['margin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['scheme_id'] = this.schemeId;
    data['unit_price'] = this.unitPrice;
    data['margin'] = this.margin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? image;
  String? color;
  String? description;
  double? price;
  int? categoryId;
  String? ram;
  String? storage;
  double? buy;
  double? margin;
  double? stock;
  String? action;
  String? createdAt;
  String? updatedAt;

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    color = json['color'];
    description = json['description'];
    price = json['price'].toDouble();
    categoryId = json['category_id'];
    ram = json['ram'];
    storage = json['storage'];
    buy = json['buy'].toDouble();
    margin = json['margin'].toDouble();
    stock = json['stock'].toDouble();
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
