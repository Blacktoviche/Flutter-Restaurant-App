import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ecommerce/modal/Asset.dart';
import 'package:ecommerce/util/Constants.dart';

import 'OnlineImage.dart';

class AppSlider extends StatelessWidget{
  final List<Asset> assets;
  AppSlider(this.assets);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 250,
      //color: Colors.redAccent,
      padding: EdgeInsets.all(5.0),
      child: Swiper(
        autoplay: true,
        autoplayDelay: 2000,
        itemBuilder: (BuildContext context, int index) {
          //print("swiperIndex: ${assets[index].id}");
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: OnlineImage(
              Constants.ASSET_ICON_URL(assets[index].id),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: assets.length,
        //viewportFraction: 0.8,
        //scale: 0.9,
        //layout: SwiperLayout.STACK,
        //itemWidth: MediaQuery.of(context).size.width,
        //pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}