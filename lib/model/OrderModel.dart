import 'dart:convert';

import 'package:ecommerce/backend/AppResponse.dart';
import 'package:ecommerce/backend/NewtworkUtils.dart';
import 'package:ecommerce/modal/Customer.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/modal/MyOrder.dart';
import 'package:ecommerce/modal/Order.dart';
import 'package:ecommerce/modal/OrderItem.dart';
import 'package:ecommerce/util/Storage.dart';
import 'package:ecommerce/util/Utils.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderModel extends Model {

  int page = 0;
  int totalElements = 0;
  int totalPages = 0;
  List items= [];
  Storage storage = Storage();
  bool loading = false;

  
  loadItems() async {
    Customer customer = await storage.getCustomer();
    if(customer == null || customer.id == null){
      //Utils.sendErrorMessage("يجب تسجيل الدخول أولا!");
      return;
    }

    AppResponse _response = await fetchItems(customer.id);
    items = _response.content;

    fillProperties(_response);
    loading = false;
    
    notifyListeners();
  }

  Future<AppResponse> fetchItems(int customerId) async {
    try {
      final response = await find(
          "orders?customerId=$customerId");
      return AppResponse.fromJson(response, Order());
    } catch (e) {
      print("exception: $e");
      List items = []; //await DBProvider.db.getMarketItemList(catId);
      AppResponse _response = new AppResponse(
          page: 0, totalElements: items.length, totalPages: 1, content: items);
      return Future.value(_response);
    }
  }

  fillProperties(_response) {
    page = _response.page;
    totalElements = _response.totalElements;
    totalPages = _response.totalPages;
  }
}
