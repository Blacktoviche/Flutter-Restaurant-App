import 'package:flutter/material.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/widgets/AppSlider.dart';
import 'package:ecommerce/widgets/OnlineImage.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

import 'ItemDetailPage.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  ItemWidget({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.slideUp, child: ItemDetailPage(item)));
        },
        splashColor: Constants.SUB_COLOR,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Container(
            decoration: BoxDecoration(
              //color: Constants.WARNING_COLOR,
              //border: Border.all(color: Constants.SUB_COLOR),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            height: 280, //MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        //color: Constants.SUB_COLOR,
                        height: 200,
                        //MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.yellowAccent),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: item.assets != null && item.assets.length > 0
                              ?  AppSlider(item.assets)
                              : Image.asset("assets/images/noImage.png",
                                  fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        top: 6.0,
                        right: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                  size: 20,
                                ),
                                Text(
                                  " ${item.rating} ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6.0,
                        left: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "${item.price}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "${item.title}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Constants.TEXT_COLOR),
                      ),
                    ),
                  ),
                  //SizedBox(height: 7.0),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "${item.detail}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Constants.TEXT_COLOR),
                      ),
                    ),
                  ),
                  //SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ));
  }
}
