import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce/model/CartModel.dart';
import 'package:ecommerce/ui/SplashScreenPage.dart';
import 'package:ecommerce/ui/cart/CartPage.dart';
import 'package:ecommerce/ui/cart/OrderPage.dart';
import 'package:ecommerce/ui/items/ItemListPage.dart';
import 'package:ecommerce/ui/profile/LoginPage.dart';
import 'package:ecommerce/ui/profile/ProfilePage.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  static const List<Widget> _children = [
    OrderPage(),
    ItemListPage(),
    LoginPage()
    //SplashScreenPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
        builder: (BuildContext context, Widget child, CartModel model) {
      return Scaffold(
        backgroundColor: Constants.MAIN_COLOR,
        /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.search),
          backgroundColor: Constants.SUB_COLOR,
        ),*/
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: _buildBottomNavBar(model),
      );
    });
  }


  BottomNavyBar _buildBottomNavBar(CartModel model){
    return BottomNavyBar(
      selectedIndex: _currentIndex,
      showElevation: true,
      backgroundColor: Colors.transparent,
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('المشتريات'),
          activeColor: Constants.SUB_COLOR,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('الرئيسية'),
            activeColor: Constants.SUB_COLOR),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('حسابي'),
            activeColor: Constants.SUB_COLOR),
      ],
    );
  }

  BottomAppBar _buildBottomAppBar(CartModel model) {
    return BottomAppBar(
        color: Constants.MAIN_COLOR,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, semanticLabel: 'الرئيسية', color: Constants.SUB_COLOR,),
              onPressed: () {_currentIndex = 0;},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, semanticLabel: 'حسابي'),
              onPressed: () {_currentIndex = 1;},
            ),
          ],
        ));
  }

  BottomNavigationBar _buildBottomNavigationBar(CartModel model) {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      backgroundColor: Constants.MAIN_COLOR,
      selectedItemColor: Constants.SUB_COLOR,
      selectedIconTheme: IconThemeData(color: Constants.SUB_COLOR),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text("المشتريات")),
        BottomNavigationBarItem(
            title: Text("الرئيسية"),
            icon: Badge(
              badgeColor: Constants.SUB_COLOR,
              shape: BadgeShape.circle,
              borderRadius: 5,
              toAnimate: true,
              badgeContent: Text("${model.cart.length}"),
              child: Icon(Icons.shopping_cart),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text("حسابي")),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
