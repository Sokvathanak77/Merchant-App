import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/features/core/screens/cart/repository/cart_repo.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartData();
  }

  void addItem(Data product, double quantity) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        if (value.quantity! > value.stock! - 1) {
          Get.snackbar('Product Quantity', 'sorry! this item is out of stock');
          return CartModel(
            id: value.id,
            name: value.name,
            image: value.image,
            color: value.color,
            price: value.price,
            ram: value.ram,
            storage: value.storage,
            buy: value.buy,
            stock: value.stock,
            quantity: value.stock,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        }
        return CartModel(
          id: value.id,
          name: value.name,
          image: value.image,
          color: value.color,
          price: value.price,
          ram: value.ram,
          storage: value.storage,
          buy: value.buy,
          stock: value.stock,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        return CartModel(
          id: product.id,
          name: product.products!.name,
          image: product.products!.image,
          color: product.products!.color,
          price: product.products!.price,
          ram: product.products!.ram,
          storage: product.products!.storage,
          buy: product.products!.buy,
          stock: product.products!.stock,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
    }
    // cartRepo.addToCartList(getItems);
    update();
  }

  void addItemsInCart(double quantity, Data product, CartModel productLocal) {
    _items.update(productLocal.id!, (value) {
      if (quantity > value.stock!) {
        Get.snackbar('Product Quantity', 'sorry! this item is out of stock');
        return CartModel(
          id: value.id,
          name: value.name,
          image: value.image,
          color: value.color,
          price: value.price,
          ram: value.ram,
          storage: value.storage,
          buy: value.buy,
          stock: value.stock,
          quantity: value.stock,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      }
      return CartModel(
        id: value.id,
        name: value.name,
        image: value.image,
        color: value.color,
        price: value.price,
        ram: value.ram,
        storage: value.storage,
        buy: value.buy,
        stock: value.stock,
        quantity: quantity,
        isExist: true,
        time: DateTime.now().toString(),
        product: product,
      );
    });
    // cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  void removeItem(CartModel productLocal) {
    Get.dialog(
      Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(top: 20),
          width: 300,
          height: 180,
          child: Column(
            children: [
              Container(
                  child: Text(
                'Do you want to delete this item?',
                style:
                    TextStyle(fontSize: 16, color: Colors.blue, inherit: false),
              )),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _items.remove(productLocal.id);
                          // cartRepo.removeLocal();
                          Get.back();
                          update();
                        },
                        child: Text('Yes')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('No')
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      transitionDuration: Duration(milliseconds: 200),
    );
    // _items.remove(productLocal.id);
    update();
  }

  void clearAll() {
    Get.dialog(
      Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(top: 20),
          width: 300,
          height: 180,
          child: Column(
            children: [
              Container(
                  child: Text(
                'Do you want to delete all item?',
                style:
                    TextStyle(fontSize: 16, color: Colors.blue, inherit: false),
              )),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _items.clear();
                          cartRepo.removeLocal();
                          Get.back();
                          update();
                        },
                        child: Text('Yes')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      transitionDuration: Duration(milliseconds: 200),
    );
    // _items.remove(productLocal.id);
    update();
  }

  double get totalItem {
    double totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = value.quantity! + totalQuantity;
    });
    return totalQuantity;
  }

  // double totalamountpercart =0;
  double totalAmountPerCart(double buy, double qty) {
    double totalamountpercart = buy * qty;
    return totalamountpercart;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.buy!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
    update();
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
  }
}
