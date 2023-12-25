import 'package:merchant/src/features/core/screens/home/model/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? image;
  String? color;
  double? price;
  String? ram;
  String? storage;
  double? buy;
  double? stock;
  double? quantity;
  bool? isExist;
  String? time;
  Data? product;

  CartModel({
    this.id,
    this.name,
    this.image,
    this.color,
    this.price,
    this.ram,
    this.storage,
    this.buy,
    this.stock,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    color = json['color'];
    price = (json['price'] as num?)?.toDouble(); // convert int to double
    ram = json['ram'];
    storage = json['storage'];
    buy = json['buy'];
    stock = (json['stock'] as num?)?.toDouble();
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = Data.fromJson(json['product']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "image":this.image,
      "color":this.color,
      "price":this.price,
      "ram":this.ram,
      "storage":this.storage,
      "buy":this.buy,
      "stock":this.stock,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "time":this.time,
      "product":this.product!.toJson(),
    };
  }
}