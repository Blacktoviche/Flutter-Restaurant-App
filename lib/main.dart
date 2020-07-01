import 'package:ecommerce/ui/MainPage.dart';
import 'package:ecommerce/ui/SplashScreenPage.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ecommerce/util/colors.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/CartModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CartModel _model = CartModel();

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primaryColor: Constants.SUB_COLOR, //MyColors.primaryColor,
        accentColor: MyColors.accentColor,
        brightness: brightness,
          bottomAppBarTheme: BottomAppBarTheme(
            shape: CircularNotchedRectangle(),
          )
        //fontFamily: 'Areal',
      ),
      themedWidgetBuilder: (context, theme) {
        return ScopedModel<CartModel>(
            model: _model,
            child: MaterialApp(
              title: 'مطعمي',
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [Locale("ar", "AR")],
              locale: Locale("ar"),
              theme: theme,
              home: SplashScreenPage(),
            ));
      },
    );
  }
}
