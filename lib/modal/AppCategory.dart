
class AppCategory {
  int id;
  String title;
  String detail;
  AppCategory parent;
  String icon;

  AppCategory({this.id, this.title, this.detail, this.parent, this.icon});

  AppCategory fromJson(Map<String, dynamic> json) {

    return AppCategory(
        id: json['id'],
        title: json['title'],
        detail: json['detail'],
        parent: json["parent"],
        icon: json["icon"]
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "detail": detail, "parent": parent, "icon": icon};
}
