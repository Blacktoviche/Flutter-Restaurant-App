
class PostResponse {
  String message;
  PostResponse(
      {this.message});

  PostResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}