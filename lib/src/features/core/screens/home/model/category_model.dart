class CategoryListModel {
  bool? success;
  List<Data>? data;

  CategoryListModel({this.success, this.data});

  CategoryListModel.fromJson(dynamic json) {
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
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.image, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

//Category Items model

class CategoryItemModel {
  bool? success;
  List<CategoryData>? data;
  String? categoryName;

  CategoryItemModel({this.success, this.data, this.categoryName});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['category_name'] = this.categoryName;
    return data;
  }
}

class CategoryData {
  int? id;
  int? productId;
  int? schemeId;
  int? unitPrice;
  int? margin;
  String? createdAt;
  String? updatedAt;
  String? action;
  Products? products;

  CategoryData(
      {this.id,
      this.productId,
      this.schemeId,
      this.unitPrice,
      this.margin,
      this.createdAt,
      this.updatedAt,
      this.action,
      this.products});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    schemeId = json['scheme_id'];
    unitPrice = json['unit_price'];
    margin = json['margin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    action = json['action'];
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
    data['action'] = this.action;
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
  int? price;
  int? categoryId;
  String? ram;
  String? storage;
  int? buy;
  int? margin;
  int? stock;
  String? action;
  String? createdAt;
  String? updatedAt;
  Category? category;

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
      this.updatedAt,
      this.category});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    color = json['color'];
    description = json['description'];
    price = json['price'];
    categoryId = json['category_id'];
    ram = json['ram'];
    storage = json['storage'];
    buy = json['buy'];
    margin = json['margin'];
    stock = json['stock'];
    action = json['action'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? description;
  Null? createdAt;
  String? updatedAt;
  String? action;

  Category(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.action});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['action'] = this.action;
    return data;
  }
}


