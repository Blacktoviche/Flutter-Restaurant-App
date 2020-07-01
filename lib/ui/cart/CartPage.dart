import 'package:ecommerce/model/CartModel.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/util/Utils.dart';
import 'package:ecommerce/widgets/NoItemsWidget.dart';
import 'package:ecommerce/widgets/OnlineImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.MAIN_COLOR,
      appBar: AppBar(
        backgroundColor: Constants.MAIN_COLOR,
        iconTheme: IconThemeData(color: Constants.SUB_COLOR),
        title: Text("طلباتي"),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0, color: Colors.transparent, child: _buildCartCheck()),
      body: CartTabSub(),
    );
  }
}

class CartTabSub extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildCartProducts(),
    );
  }

  Widget _buildCartProducts() {
    return ScopedModelDescendant<CartModel>(
        builder: (BuildContext inContext, Widget inChild, CartModel model) {
      if (model.itemsMap.keys.length > 0) {
        return ListView.builder(
          itemCount: model.itemsMap.keys.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Item item = model.itemsMap.keys.toList()[index];
            int count = model.itemsMap[item];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                model.removeAllFromCart(item);
              },
              background: Container(
                  color: Constants.SUB_COLOR,
                  child: Center(
                    child: Text(
                      'إزالة',
                      style: TextStyle(color: Constants.TEXT_COLOR),
                    ),
                  )),
              secondaryBackground: Container(
                  color: Constants.SUB_COLOR,
                  child: Center(
                    child: Text(
                      'إزالة',
                      style: TextStyle(color: Constants.TEXT_COLOR),
                    ),
                  )),
              child: CartItemWidget(item: item, count: count),
            );
          },
          controller: _scrollController,
        );
      } else {
        return NoItemsWidget("لا يوجد مشتريات!");
      }
    });
  }
}

Widget _buildCartCheck() {
  return ScopedModelDescendant<CartModel>(
      builder: (BuildContext inContext, Widget inChild, CartModel model) {
    return Container(
        //color: Colors.transparent,
        width: double.infinity,
        height: 120,
        foregroundDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            //shape: BoxShape.circle,
            border: Border.all(width: 1, color: Constants.SUB_COLOR)),
        //padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "   المجموع : ${model.sum}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Constants.SUB_COLOR),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: model.saving ? SpinKitWave(
                color: Constants.SUB_COLOR,
              ) : OutlineButton(
                borderSide: BorderSide.none,
                color: Colors.transparent,
                child: Text(
                  "إرسال الطلبية",
                  style: TextStyle(color: Constants.SUB_COLOR),
                ),
                onPressed: () {model.order();},
              ),
            )
          ],
        )
        //)
        );
  });
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key key, this.item, this.count})
      : super(key: key);

  final Item item;
  final int count;

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
                    child: item.assets != null && item.assets.length > 0
                        ? OnlineImage(
                            Constants.ASSET_ICON_URL(item.assets[0].id),
                            height: 80.0,
                            width: 100,
                            withRadious: true,
                          )
                        : Image.asset(
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
                        item.title,
                        style: TextStyle(
                            //fontFamily: "Alarabiya",
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: Constants.SUB_COLOR),
                      ),
                      Text(Utils.getShortDetail(Utils.parseHTML(item.detail)),
                          style: TextStyle(color: Constants.LIGHT_COLOR))
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Constants.SUB_COLOR,
                        ),
                        //color: Colors.green,
                        onPressed: () => model.addToCart(item)),
                    const SizedBox(width: 10.0),
                    Text(
                      "$count",
                      style: TextStyle(color: Constants.SUB_COLOR),
                    ),
                    const SizedBox(width: 10.0),
                    IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Constants.SUB_COLOR,
                        ),
                        //color: Colors.green,
                        onPressed: () => model.removeFromCart(item)),
                    const SizedBox(width: 5.0),
                    Text(
                      "${count * item.price}",
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
