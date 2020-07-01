import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce/modal/AppCategory.dart';
import 'package:ecommerce/model/CartModel.dart';
import 'package:ecommerce/modal/Item.dart';
import 'package:ecommerce/model/ItemModel.dart';
import 'package:ecommerce/ui/cart/CartPage.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

import 'CategoryWidget.dart';
import 'FeaturedItemWidget.dart';
import 'ItemWidget.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key key}) : super(key: key);

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final ItemModel model = ItemModel();

  @override
  void initState() {
    model.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
        builder: (BuildContext inContext, Widget inChild, CartModel cartModel) {
      return Scaffold(
        backgroundColor: Constants.MAIN_COLOR,
        appBar: _buildAppBar(cartModel),
        body: SafeArea(
          child: MainTabSub(model),
        ),
      );
    });
  }

  Widget _buildAppBar(CartModel cartModel) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Constants.SUB_COLOR,
            icon: Badge(
              badgeColor: Constants.SUB_COLOR,
              shape: BadgeShape.circle,
              borderRadius: 5,
              toAnimate: true,
              badgeContent: Text("${cartModel.cart.length}"),
              child: Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.slideZoomUp, child: CartPage()));
            },
          ),
          title: Container(
            child: Card(
              child: Container(
                color: Constants.MAIN_COLOR,
                child: TextField(
                  style: TextStyle(color: Constants.SUB_COLOR),
                  decoration: InputDecoration(

                      hintText: "  بحث ..",
                      //focusColor: Constants.SUB_COLOR,
                      hintStyle: TextStyle(color: Constants.SUB_COLOR),
                      filled: true,
                      fillColor: Constants.MAIN_COLOR,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Constants.SUB_COLOR,
                      ) //IconButton(onPressed: (){}, icon: Icon(Icons.search))
                      ),
                ),
              ),
            ),
          ),
          //leading: OnlineImage("deliveryIcon"),
        ),
      ),
    );
  }
}

class MainTabSub extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemModel model;

  MainTabSub(ItemModel model) {
    this.model = model;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("max scroll ....");
        model.loadItemsMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              children: <Widget>[
                _buildFeaturedProducts(context),
                _buildCategories(context),
                Expanded(
                  child: _buildProducts(context),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return ScopedModel<ItemModel>(
        model: model,
        child: ScopedModelDescendant<ItemModel>(builder:
            (BuildContext inContext, Widget inChild, ItemModel model) {
          if (model.loadingFeatured) {
            return SpinKitCircle(
              color: Constants.PROGRESS_COLOR,
              size: 100,
            );
          } else {
            return Container(
              height: 125,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (BuildContext context, int index) {
                  return FeaturedItemWidget(item: model.featuredItems[index]);
                },
                itemCount: model.featuredItems.length,
              ),
            );
          }
        }));
  }

  Widget _buildProducts(BuildContext context) {
    return ScopedModel<ItemModel>(
        model: model,
        child: ScopedModelDescendant<ItemModel>(builder:
            (BuildContext inContext, Widget inChild, ItemModel model) {
          if (model.loadingCat) {
            return SpinKitCircle(
              color: Constants.PROGRESS_COLOR,
              size: 100,
            );
          } else {
            if (model.loading) {
              return SpinKitCircle(
                color: Constants.PROGRESS_COLOR,
                size: 100,
              );
            } else {
              return LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  onRefresh: () => model.refreshItems(),
                  scrollController: _scrollController,
                  backgroundColor: Constants.MAIN_COLOR,
                  color: Constants.SUB_COLOR,
                  child: ListView.builder(
                    itemCount: model.items.length,
                    //shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == model.items.length) {
                        return SpinKitCircle(
                          color: Constants.PROGRESS_COLOR,
                          size: 100,
                        );
                      } else {
                        Item item = model.items[index];
                        return ItemWidget(item: item);
                      }
                    },
                    controller: _scrollController,
                  ));
            }
          }
        }));
  }

  Widget _buildCategories(context) {
    return ScopedModel<ItemModel>(
      model: model,
      child: ScopedModelDescendant<ItemModel>(builder:
          (BuildContext inContext, Widget inChild, ItemModel model) {
        if (model.loadingCat) {
          return SpinKitWave(
            color: Constants.PROGRESS_COLOR,
            size: 30,
            type: SpinKitWaveType.center,
          );
        } else if (model.categories.length == 0) {
          return IconButton(
            icon: Icon(
              Icons.refresh,
              color: Constants.SUB_COLOR,
              size: 30,
            ),
            onPressed: () => model.loadItems(),
          );
        } else {
          return Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return CategoryWidget(
                    item: model.categories[index], model: model);
              },
              itemCount: model.categories.length,
            ),
          );
        }
      }),
    );
  }
}
