import 'package:ecommerce/modal/Item.dart';
import "package:scoped_model/scoped_model.dart";
import 'package:ecommerce/backend/AppResponse.dart';
import 'package:ecommerce/backend/DBProvider.dart';
import 'package:ecommerce/backend/NewtworkUtils.dart';
import 'package:ecommerce/modal/AppCategory.dart';
import 'package:ecommerce/util/Constants.dart';

class ItemModel extends Model {
  List items = [];
  List featuredItems = [];
  int page = 0;
  int totalElements = 0;
  int totalPages = 0;
  bool loading = false;
  bool loadingFeatured = false;
  bool loadingMore = false;
  bool loadingCat = false;
  String searchValue;
  int selectedCategory;
  String title;
  List categories = [];

  loadItems() async {
    await loadCategories();
    findFeaturedItems();
    filterItems(null);
  }

  refreshItems() async {
    loading = true;
    notifyListeners();
    page = 0;
    AppResponse _response = await fetchItems();
    items = _response.content;
    fillProperties(_response);
    loading = false;
    notifyListeners();
  }

  findFeaturedItems() async {
    loadingFeatured = true;
    notifyListeners();
    AppResponse _response = await fetchFeaturedItems();
    featuredItems = _response.content;
    fillProperties(_response);
    loadingFeatured = false;
    notifyListeners();
  }

  searchItems(String value) async {
    loading = true;
    notifyListeners();
    page = 0;
    searchValue = value;
    AppResponse _response = await fetchItems();
    items = _response.content;
    fillProperties(_response);
    loading = false;
    notifyListeners();
  }

  loadItemsMore() async {
    page += 1;
    AppResponse _response = await fetchItems();
    items.addAll(_response.content);
    fillProperties(_response);
    notifyListeners();
  }

  loadCategories() async {
    loadingCat = true;
    AppResponse _response = await fetchCategories();
    categories = _response.content;
    loadingCat = false;
    notifyListeners();
  }

  filterItems(int categoryId) async {
    if (categoryId == selectedCategory) {
      selectedCategory = null;
    } else {
      selectedCategory = categoryId;
    }
    loading = true;
    notifyListeners();
    page = 0;
    AppResponse _response = await fetchItems();
    items = _response.content;
    fillProperties(_response);
    loading = false;
    notifyListeners();
  }

  fillProperties(_response) {
    page = _response.page;
    totalElements = _response.totalElements;
    totalPages = _response.totalPages;
  }

  Future<AppResponse> fetchCategories() async {
    try {
      final response = await find("categories");
      return AppResponse.fromJson(response, AppCategory());
    } catch (e) {
      print("exceptionC: $e");
      List items = []; //await DBProvider.db.getMarketItemList(catId);
      AppResponse _response = new AppResponse(
          page: 0, totalElements: items.length, totalPages: 1, content: items);
      return Future.value(_response);
    }
  }

  Future<AppResponse> fetchFeaturedItems() async {
    try {
      final response = await find(
          "categories/items/featured/?sort=updatedAt,DESC");
      return AppResponse.fromJson(response, Item());
    } catch (e) {
      print("exception: $e");
      List items = []; //await DBProvider.db.getMarketItemList(catId);
      AppResponse _response = new AppResponse(
          page: 0, totalElements: items.length, totalPages: 1, content: items);
      return Future.value(_response);
    }
  }

  Future<AppResponse> fetchItems() async {
    try {
      final response = await find(
          "categories/items/?${selectedCategory != null ? 'parent=$selectedCategory&' : ''}${searchValue != null && searchValue.trim().isNotEmpty ? 'searchValue=$searchValue&' : ''}page=$page&size=${Constants.PAGE_SIZE}&sort=updatedAt,DESC");
      return AppResponse.fromJson(response, Item());
    } catch (e) {
      print("exception: $e");
      List items = []; //await DBProvider.db.getMarketItemList(catId);
      AppResponse _response = new AppResponse(
          page: 0, totalElements: items.length, totalPages: 1, content: items);
      return Future.value(_response);
    }
  }

  void saveItems(List items) {
    //DBProvider.db.saveMarketItemList(items);
  }
}
