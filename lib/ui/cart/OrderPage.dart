import 'package:ecommerce/modal/Order.dart';
import 'package:ecommerce/modal/OrderItem.dart';
import 'package:ecommerce/model/CartModel.dart';
import 'package:ecommerce/model/OrderModel.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/widgets/NoItemsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final ScrollController _scrollController = new ScrollController();
  final OrderModel model = OrderModel();

  @override
  void initState() {
    model.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.MAIN_COLOR,
      appBar: AppBar(
        title: Text("الطلبات القديمة", style: TextStyle(color: Constants.SUB_COLOR),),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      body: SingleChildScrollView(
        child: ScopedModel<OrderModel>(
          model: model,
          child: ScopedModelDescendant<OrderModel>(builder:
              (BuildContext inContext, Widget inChild, OrderModel model) {
            if (model.loading) {
              return Center(
                child: SpinKitFadingFour(
                  color: Constants.SUB_COLOR,
                ),
              );
            } else {
              if (model.items.length > 0) {
                return ListView.builder(
                  itemCount: model.items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Order order = model.items[index];
                    List<OrderItemWidget> itemWidgets = [];
                    for (OrderItem orderItem in order.orderItems) {
                      itemWidgets.add(OrderItemWidget(item: orderItem));
                    }
                    String title = DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(order.orderDate));
                    return ExpansionTile(
                      title: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text(
                            "$title",
                            style: TextStyle(color: Constants.SUB_COLOR)),
                       // SizedBox(width: 10,),
                        Text(
                            "المجموع : ${order.totalPrice}",
                            style: TextStyle(color: Constants.SUB_COLOR))
                      ],),
                      trailing: Icon(
                        Icons.expand_more,
                        color: Constants.SUB_COLOR,
                      ),
                      //backgroundColor: Constants.SUB_COLOR,
                      children: itemWidgets,
                    );
                  },
                  controller: _scrollController,
                );
              } else {
                return Center(
                  heightFactor: 5.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Constants.SUB_COLOR,
                      size: 30,
                    ),
                    onPressed: () => model.loadItems(),
                  ),
                );
              }
            }
          }),
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({Key key, this.item}) : super(key: key);

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
        builder: (BuildContext context, Widget child, CartModel model) {
      return Card(
          color: Colors.black54,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          elevation: 10,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Constants.SUB_COLOR)),
          child: Container(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10.0),
                Container(
                    //color: Colors.transparent,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.transparent),
                    height: 80.0,
                    child: Image.asset(
                      "assets/images/noImage.png",
                      height: 80.0,
                      width: 100,
                    )),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.itemName,
                        style: TextStyle(
                            //fontFamily: "Alarabiya",
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: Constants.SUB_COLOR),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Text(
                      "العدد : ${item.quantity}",
                      style: TextStyle(color: Constants.SUB_COLOR),
                    ),
                    const SizedBox(height: 10.0),
                    //const SizedBox(width: 10.0),
                    Text(
                      "السعر : ${item.quantity * item.price}",
                      style: TextStyle(color: Constants.SUB_COLOR),
                    ),
                  ],
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ));
    });
  }
}
