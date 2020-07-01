import 'AppCategory.dart';
import 'Asset.dart';

class Item {
  final int id;
  final String title;
  final String detail;
  final double price;
  final double rating;
  final List<Asset> assets;
  final String updatedAt;
  final int categoryId;

  //final int areaId;
  Item(
      {this.id,
        this.title,
        this.detail,
        this.price,
        this.rating,
        this.assets,
        this.updatedAt,
        this.categoryId});

   Item fromJson(Map<String, dynamic> map) {
    var list = map['assets'] as List;
    List<Asset> assets = new List();
    if (list != null) {
      assets = list.map((i) => Asset.fromJson(i)).toList();
    }

    AppCategory category = AppCategory().fromJson(map['parent']);

    return Item(
        id: map['id'],
        title: map['title'],
        detail: map['detail'],
        price: map['price'],
        rating: map['rating'],
        assets: assets,
        updatedAt: map['updatedAt'],
        categoryId: category.id);
  }

}
