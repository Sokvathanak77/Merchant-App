class CartHistoryModel {
  bool? success;
  List<List<CartItem>>? data;
  List<int>? invoice;
  List<int>? total;

  CartHistoryModel({
    this.success,
    this.data,
    this.invoice,
    this.total,
  });

  factory CartHistoryModel.fromJson(dynamic json) {
    return CartHistoryModel(
      success: json['success'],
      data: List<List<CartItem>>.from(json['data'].map((x) => List<CartItem>.from(x.map((x) => CartItem.fromJson(x))))),
      invoice: List<int>.from(json['invoice']),
      total: List<int>.from(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': List<dynamic>.from(data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      'invoice': List<dynamic>.from(invoice!),
      'total': List<dynamic>.from(total!),
    };
  }
}

class CartItem {
  int? id;
  int? orderId;
  String? productId;
  int? qty;
  int? unitPrice;
  int? discount;
  int? total;
  DateTime? createdAt;
  DateTime? updatedAt;
  Order? order;
  Product? product;

  CartItem({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.unitPrice,
    this.discount,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      qty: json['qty'],
      unitPrice: json['unit_price'],
      discount: json['discount'],
      total: json['total'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      order: Order.fromJson(json['order']),
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'qty': qty,
      'unit_price': unitPrice,
      'discount': discount,
      'total': total,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'order': order?.toJson(),
      'product': product?.toJson(),
    };
  }
}

class Order {
  int? id;
  int? invoice;
  String? userId;
  String? addressId;
  String? payBy;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Order({
    this.id,
    this.invoice,
    this.userId,
    this.addressId,
    this.payBy,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      invoice: json['invoice'],
      userId: json['user_id'],
      addressId: json['address_id'],
      payBy: json['pay_by'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice': invoice,
      'user_id': userId,
      'address_id': addressId,
      'pay_by': payBy,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Product {
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
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      color: json['color'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      ram: json['ram'],
      storage: json['storage'],
      buy: json['buy'],
      margin: json['margin'].toDouble(),
      stock: json['stock'],
      action: json['action'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'color': color,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'ram': ram,
      'storage': storage,
      'buy': buy,
      'margin': margin,
      'stock': stock,
      'action': action,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}