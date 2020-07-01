import 'package:ecommerce/ui/items/ItemDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/widgets/AppSlider.dart';
import 'package:ecommerce/widgets/OnlineImage.dart';

class FeaturedItemWidget extends StatelessWidget {
  final Item item;

  const FeaturedItemWidget({Key key, this.item});

  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      splashColor: Constants.SUB_COLOR,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ItemDetailPage(item)));
      },
      child: Container(
        height: 125,
        width: 140,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          //border: Border.all(color: Constants.SUB_COLOR),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        //padding: EdgeInsets.only(left: 10,right: 10),
        child: Hero(
          tag: "PItem${item.id}",
          child: Stack(
            children: <Widget>[
              item.assets != null && item.assets.length > 0
                  ? OnlineImage(
                Constants.ASSET_ICON_URL(item.assets[0].id),
                fit: BoxFit.cover,
                withRadious: true,
              )
                  : Image.asset(
                "assets/images/noImage.png",
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 2.0,
                left: 2.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "${item.price}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
