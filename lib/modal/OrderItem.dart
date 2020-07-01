import 'package:ecommerce/modal/Order.dart';

class OrderItem {
  final int id;
  final int itemId;
  final String itemName;
  final double price;
  final int quantity;
  final double totalPrice;
  //final int orderId;

  OrderItem(
      {this.id,
        this.itemId,
        this.itemName,
        this.price,
        this.quantity,
        this.totalPrice,
        //this.orderId
      });

  OrderItem fromJson(Map<String, dynamic> map) {

    //Order order = Order().fromJson(map['order']);

    return OrderItem(
        id: map['id'],
        itemId: map['itemId'],
        itemName: map['itemName'],
        price: map['price'],
        quantity: map['quantity'],
        totalPrice: map['totalPrice'],
        //orderId: order.id
    );
  }

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "quantity": quantity
  };
}
