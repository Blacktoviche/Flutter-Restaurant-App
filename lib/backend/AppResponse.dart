
class AppResponse {
  int page;
  int totalElements;
  int totalPages;
  List content;

  AppResponse(
      {this.page, this.totalElements, this.totalPages, this.content});

  AppResponse.fromJson(Map<String, dynamic> json, dynamic modal) {

    page = json['pageable']['pageNumber'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    if (json['content'] != null) {
      content = new List();
      json['content'].forEach((v) {
        content.add(modal.fromJson(v));
      });
    }
  }
}