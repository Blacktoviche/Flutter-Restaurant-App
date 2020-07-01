import 'dart:math' as math;
import 'dart:ui';
import 'package:ecommerce/modal/AppCategory.dart';
import 'package:ecommerce/model/ItemModel.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/util/colors.dart';
import 'package:ecommerce/util/functions.dart';
import 'package:ecommerce/widgets/AppTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

import 'OnlineImage.dart';

const double minHeight = 80;
const double iconStartSize = 75;
const double iconEndSize = 110;
const double iconStartMarginTop = -15;
const double iconEndMarginTop = 50;
const double iconsVerticalSpacing = 0;
const double iconsHorizontalSpacing = 0;
AnimationController controller;

void toggleBottomSheet() =>
    controller.fling(velocity: isBottomSheetOpen ? -2 : 2);

bool get isBottomSheetOpen => (controller.status == AnimationStatus.completed);

class AppBottomSheet extends StatefulWidget {
  final ItemModel model;
  final ScrollController _scrollController = new ScrollController();

  AppBottomSheet(this.model);

  @override
  _AppBottomSheetState createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet>
    with SingleTickerProviderStateMixin {
  double get maxHeight => MediaQuery.of(context).size.height;

  double get headerTopMargin =>
      lerp(16, 50 + MediaQuery.of(context).padding.top);

  double get itemBorderRadius => lerp(8, 15);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => itemBorderRadius;

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(
        iconStartMarginTop,
        iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize),
      ) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    widget._scrollController.addListener(() {
      if (widget._scrollController.position.pixels ==
          widget._scrollController.position.maxScrollExtent) {
        print("max scroll category....");
        if (widget.model.totalElements != widget.model.items.length) {
          //widget.model.loadItemsMore();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) => lerpDouble(min, max, controller.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: toggleBottomSheet,
            onVerticalDragUpdate: handleDragUpdate,
            onVerticalDragEnd: handleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: shadowColor(context),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Material(
                color: invertInvertColorsMild(context),
                elevation: 10.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                shadowColor: shadowColor(context),
                child: InkWell(
                  onTap: doNothing,
                  splashColor: invertColorsStrong(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: _buildStack(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryListSmall() {
    return ScopedModel<ItemModel>(
      model: widget.model,
      child: ScopedModelDescendant<ItemModel>(builder:
          (BuildContext inContext, Widget inChild, ItemModel model) {
        if (model.loading) {
          return SpinKitChasingDots(
            color: Constants.PROGRESS_COLOR,
            size: 100,
          );
        } else {
          return ListView.builder(
            itemCount: model.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == model.categories.length) {
                return model.totalElements != model.categories.length
                    ? SpinKitPouringHourglass(
                        color: Constants.PROGRESS_COLOR,
                        size: 100,
                      )
                    : null;
              } else {
                AppCategory item = model.categories[index];
                return buildIcon(item);
              }
            },
            controller: widget._scrollController,
          );
        }
      }),
    );
  }

  Widget _buildCategoryList() {
    return ScopedModel<ItemModel>(
      model: widget.model,
      child: ScopedModelDescendant<ItemModel>(builder:
          (BuildContext inContext, Widget inChild, ItemModel model) {
        if (model.loading) {
          return SpinKitChasingDots(
            color: Constants.PROGRESS_COLOR,
            size: 100,
          );
        } else {
          return LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => model.loadItems(),
              scrollController: widget._scrollController,
              color: GradientColors.lightEnd,
              child: ListView.builder(
                itemCount: model.categories.length,
                itemBuilder: (context, index) {
                  if (index == model.categories.length) {
                    return model.totalElements != model.categories.length
                        ? SpinKitPouringHourglass(
                            color: Constants.PROGRESS_COLOR,
                            size: 100,
                          )
                        : null;
                  } else {
                    AppCategory item = model.categories[index];
                    return ExpandedSheetItem(
                      isVisible: controller.status == AnimationStatus.completed,
                      borderRadius: itemBorderRadius,
                      title: item.title,
                    );
                  }
                },
                controller: widget._scrollController,
              ));
        }
      }),
    );
  }

  Widget buildIcon(AppCategory item) {
    //int index = items.indexOf(item);
    return Container(
      padding: EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: OnlineImage(
          Constants.APP_CATEGORY_ICON_URL(item.id),
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        )
        /*Image.asset(
            'assets/images/icon/icon-nobg.png',
            fit: BoxFit.cover,
            alignment: Alignment(lerp(0, 0), 0),
          )*/
        ,
      ),
    );
  }


  Widget buildIcon2(List items, AppCategory item, ItemModel model) {
    int index = items.indexOf(item);
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: OnlineImage(
            Constants.APP_CATEGORY_ICON_URL(item.id),
            fit: BoxFit.cover,
          )
          /*Image.asset(
            'assets/images/icon/icon-nobg.png',
            fit: BoxFit.cover,
            alignment: Alignment(lerp(0, 0), 0),
          )*/
          ,
        ),
      ),
    );
  }

  Widget buildFullItem(List items, AppCategory item) {
    int index = items.indexOf(item);
    return ExpandedSheetItem(
      isVisible: controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: item.title,
    );
  }


  List<Widget> _buildStack(){
    List<Widget> lista = List();
    for (AppCategory item in widget.model.categories)
      lista.add(buildFullItem2(
          widget.model.categories, item, widget.model));

    for (AppCategory item in widget.model.categories)
       lista.add(buildIcon2(widget.model.categories, item, widget.model));

    return lista;
  }

  Widget buildFullItem2(List items, AppCategory item, ItemModel model) {
    int index = items.indexOf(item);
    return ExpandedSheetItem2(
        topMargin: iconTopMargin(index),
        leftMargin: iconLeftMargin(index),
        height: iconSize,
        isVisible: controller.status == AnimationStatus.completed,
        borderRadius: itemBorderRadius,
        item: item,
        model: model);
  }

  void handleDragUpdate(DragUpdateDetails details) {
    controller.value -= details.primaryDelta / maxHeight;
  }

  void handleDragEnd(DragEndDetails details) {
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      controller.fling(
        velocity: math.max(2.0, -flingVelocity),
      );
    else if (flingVelocity > 0.0)
      controller.fling(
        velocity: math.min(-2.0, -flingVelocity),
      );
    else
      controller.fling(velocity: controller.value < 0.5 ? -2.0 : 2.0);
  }
}

class ExpandedSheetItem extends StatelessWidget {
  final bool isVisible;
  final double borderRadius;
  final String title;

  const ExpandedSheetItem(
      {Key key, this.isVisible, this.borderRadius, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: Duration(milliseconds: 200),
      child: AppTile(
        color: invertColorsMaterial(context),
        splashColor: MyColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 25.0,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: invertColorsMild(context),
                ),
              ),
            ),
          ],
        ),
        onTap: doNothing,
      ),
    );
  }
}

class ExpandedSheetItem2 extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final AppCategory item;
  final ItemModel model;

  const ExpandedSheetItem2({
    Key key,
    this.topMargin,
    this.height,
    this.isVisible,
    this.borderRadius,
    this.item,
    this.model,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: AppTile(
          color: invertColorsMaterial(context),
          splashColor: GradientColors.lightEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 50.0,
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: invertColorsMild(context),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            model.filterItems(item.id);
            toggleBottomSheet();
          },
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        Text(
          'Fix me title',
        ),
      ],
    );
  }
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {}
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: toggleBottomSheet,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          size: 24.0,
          progress: controller,
          semanticLabel: 'Open/close',
          color: invertColorsMild(context),
        ),
      ),
    );
  }
}
