import 'package:ecommerce/model/CartModel.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/widgets/AppSlider.dart';
import 'package:ecommerce/widgets/OnlineImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemDetailPage extends StatelessWidget {
  final Color icon = Color(0xffEF412D);
  final Color color1 = Color(0xffCF3529);
  final Color color2 = Color(0xffE1372F);
  final Color color3 = Color(0xffFF6C1C);
  final Item item;

  ItemDetailPage(this.item);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
        builder: (BuildContext context, Widget child, CartModel model) {
      return Scaffold(
        body: Container(
          color: Constants.MAIN_COLOR,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(color: Constants.MAIN_COLOR
                        /*gradient: LinearGradient(
                          colors: [color2, color3],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      )*/
                        ),
                  )),
              Positioned(
                  top: 350,
                  left: 0,
                  right: 150,
                  bottom: 80,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Constants.SUB_COLOR,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0))),
                  )),
              Positioned(
                top: 350,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Text(
                        item.title,
                        style: TextStyle(
                            color: Constants.TEXT_COLOR,
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        item.detail,
                        style: TextStyle(color: Constants.TEXT_COLOR),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
              Container(
                height: 380,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black38, blurRadius: 30.0)
                ]),
                child: SizedBox(
                  height: 350,
                  child: Hero(
                    tag: "PItem${item.id}",
                    child: AppSlider(item.assets),
                  ),
                ),
              ),
              Positioned(
                top: 325,
                left: 20,
                child: OutlineButton(
                  //color: Colors.transparent,
                  highlightedBorderColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  splashColor: Constants.SUB_COLOR,
                  onPressed: () => model.addToCart(item),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                ),
              ),
              Positioned(
                top: 325,
                right: 20,
                child: RaisedButton(
                  child: Text(
                    "${item.price}",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Container(
                  height: 70.0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )),
            ],
          ),
        ),
      );
    });
  }
}
