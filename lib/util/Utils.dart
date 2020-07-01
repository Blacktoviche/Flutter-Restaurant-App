import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

class Utils {

  static bool isThemeCurrentlyDark(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }

  static sendErrorMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static sendSuccessMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Constants.SUB_COLOR,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String getPriceFormat(price, currency) {
    return "$price ${getCurrencyText(currency)}";
  }

  static String parseHTML(String html) {
    return parse(parse(html).body.text).documentElement.text;
  }

  static String getShortDetail(String detail) {
    if (detail.length > 60) {
      return "${detail.substring(0, 60)}...";
    } else {
      return detail;
    }
  }

  static void addToCart(dynamic product) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(Constants.CART_KEY);
    if(cart == null){
      cart = [];
      cart.add("${product.id}");
    }
    await prefs.setStringList(Constants.CART_KEY, cart);
  }

  static String getCurrencyText(currency) {
    switch (currency) {
      case 0:
        return "دولار";
      case 1:
        return "ليرة تركية";
      case 2:
        return "ليرة سورية";
      default:
        return "دولار";
    }
  }
}
