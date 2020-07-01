import 'package:ecommerce/modal/Customer.dart';
import 'package:ecommerce/modal/OrderItem.dart';

import 'AppCategory.dart';
import 'Asset.dart';

class Order {
  final int id;
  final String orderDate;
  final double totalPrice;
  final bool finished;
  final String orderNumber;
  final String updatedAt;
  final int customerId;
  final List<OrderItem> orderItems;

  Order(
      {this.id,
      this.orderDate,
      this.totalPrice,
      this.finished,
      this.orderNumber,
      this.updatedAt,
      this.customerId,
      this.orderItems});

  Order fromJson(Map<String, dynamic> map) {

    var list = map['orderItems'] as List;
    List<OrderItem> orderItems = new List();
    if (list != null) {
      orderItems = list.map((i) => OrderItem().fromJson(i)).toList();
    }

    Customer customer = Customer().fromJson(map['customer']);

    return Order(
        id: map['id'],
        orderDate: map['orderDate'],
        totalPrice: map['totalPrice'],
        finished: map['finished'],
        orderNumber: map['orderNumber'],
        updatedAt: map['updatedAt'],
        customerId: customer.id,
        orderItems: orderItems);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalPrice": totalPrice,
    "orderItems": orderItems,
  };
}
