
import 'Item.dart';

class MyOrder {
  final int id;
  final String orderDate;
  final double totalPrice;
  final String orderNumber;
  final Map<Item, int> itemsMap;

  MyOrder({this.id, this.orderDate, this.totalPrice,this.orderNumber, this.itemsMap});

}