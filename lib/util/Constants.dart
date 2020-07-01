import 'package:flutter/material.dart';

class Constants {

  static const PRIMARY_COLOR = Color(0xFF20a8d8);
  static const SECONDARY_COLOR = Color(0xFFc8ced3);
  static const SUCCESS_COLOR = Color(0xFF4dbd74);
  static const DANGER_COLOR = Color(0xFFf86c6b);
  static const WARNING_COLOR = Color(0xFFffc107);
  static const INFO_COLOR = Color(0xFF63c2de);
  static const DARK_COLOR = Color(0xFF2f353a);
  static const LIGHT_COLOR = Color(0xFFf0f3f5);

  static const ORANGE_COLOR = Color(0xffff6d00);

  //static const PROGRESS_COLOR = WARNING_COLOR;
  static const PROGRESS_COLOR = SUB_COLOR;//Color(0xFFc56cf0);

  static const MAIN_COLOR = DARK_COLOR;//Colors.white;
  //static const MAIN_COLOR = DARK_COLOR;
  static const SUB_COLOR = ORANGE_COLOR;//WARNING_COLOR;
  //static const SUB_COLOR = Color(0xFFd35400);

  static const TEXT_COLOR = LIGHT_COLOR;
  //static const TEXT_COLOR = LIGHT_COLOR;

  static const int PAGE_SIZE = 10;

  static const String CART_KEY = "CART";

  static String API_CLIENT_DOMAIN(String endPoint) => "http://localhost:7555/client/v1/$endPoint";

  static String APP_CATEGORY_ICON_URL(int id) => API_CLIENT_DOMAIN("categories/icon/$id");

  static String ASSET_ICON_URL(int id) => API_CLIENT_DOMAIN("assets/$id");
}
