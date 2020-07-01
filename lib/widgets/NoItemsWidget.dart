import 'package:flutter/material.dart';
import 'package:ecommerce/util/Constants.dart';

class NoItemsWidget extends StatelessWidget {
  String title = "";
  NoItemsWidget(String title){
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height/2-30),
          Icon(
            Icons.search,
            size: 50.0,
            color: Constants.SUB_COLOR,
          ),
          Text(title, style: TextStyle(color: Constants.SUB_COLOR, fontSize: 18),),
        ],
      ),
    );
  }
}
