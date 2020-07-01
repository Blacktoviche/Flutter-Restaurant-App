import 'package:ecommerce/modal/AppCategory.dart';
import 'package:ecommerce/model/ItemModel.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/util/colors.dart';
import 'package:ecommerce/widgets/OnlineImage.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({this.item, this.model});

  final AppCategory item;
  final ItemModel model;

  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 150,
        height: 100,
        //color: Constants.SUB_COLOR,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Constants.SUB_COLOR,
          border: Border.all(width: model.selectedCategory == item.id ? 2 : 0, color: GradientColors.lightEnd)
        ),
        child: Row(
          children: <Widget>[
            OnlineImage(
              Constants.APP_CATEGORY_ICON_URL(item.id),
              width: 100,
              height: 100,
            ),
            Flexible(
              child: Text(item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Constants.TEXT_COLOR,
                  )),
            )
          ],
        ),
      ),
      splashColor: GradientColors.lightEnd,
      borderRadius: BorderRadius.circular(10.0),
      onTap: () => model.filterItems(item.id),
    );
  }
}
