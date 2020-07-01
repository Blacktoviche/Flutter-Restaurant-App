import 'dart:convert';

import 'package:ecommerce/backend/AppResponse.dart';
import 'package:ecommerce/backend/NewtworkUtils.dart';
import 'package:ecommerce/modal/Customer.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/modal/Order.dart';
import 'package:ecommerce/modal/OrderItem.dart';
import 'package:ecommerce/util/Storage.dart';
import 'package:ecommerce/util/Utils.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  Storage storage = Storage();
  List<Item> cart = [];
  Map<Item, int> itemsMap = {};
  double sum = 0.0;
  bool saving = false;

  addToCart(Item item) {
    sum += item.price;
    if (!cart.contains(item)) {
      cart.add(item);
    }

    if (itemsMap.containsKey(item)) {
      int count = itemsMap[item];
      count++;
      itemsMap[item] = count;
    } else {
      itemsMap[item] = 1;
    }
    Utils.sendSuccessMessage("تم إضافة ${item.title} الى السلّة");
    notifyListeners();
  }

  removeFromCart(Item item) {
    sum -= item.price;
    if (itemsMap.containsKey(item)) {
      int count = itemsMap[item];
      if (count == 1) {
        itemsMap.remove(item);
        cart.remove(item);
      } else {
        count--;
        itemsMap[item] = count;
      }
    }
    notifyListeners();
  }

  removeAllFromCart(Item item) {
    if (itemsMap.containsKey(item)) {
      int count = itemsMap[item];
      itemsMap.remove(item);
      sum -= (item.price * count);
      cart.remove(item);
    }
    notifyListeners();
  }

  order() async {
    if (itemsMap.isEmpty) {
      Utils.sendErrorMessage("لا يوجد طلبات لإرسالها!");
      return;
    }
    Customer customer = await storage.getCustomer();

    if(customer == null || customer.id == null){
      Utils.sendErrorMessage("لا يمكنك ارسال طلبات بدون تسجيل الدخول!");
      return;
    }

    saving = true;
    List<OrderItem> orderItems = [];
    for (Item item in itemsMap.keys) {
      orderItems.add(OrderItem(itemId: item.id, quantity: itemsMap[item]));
    }
    await sendOrder(orderItems, customer.id);

    saving = false;
    notifyListeners();
  }

  Future<AppResponse> sendOrder(List orderItems, int customerId) async {
    try {
      final response = await send("orders?customerId=$customerId",
          jsonEncode(Order(orderItems: orderItems).toJson()));
      Utils.sendSuccessMessage("تم ارسال الطلبية بنجاح");
      itemsMap.clear();
      return Future.value(null);
    } catch (e) {
      print("exceptionC: $e");
      Utils.sendErrorMessage(e.message);
      //PostResponse _response = new PostResponse(message: e.message);
      return Future.value(null);
    }
  }
}
