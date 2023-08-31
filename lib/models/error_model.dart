class ErrorModel {

  String? message;

  ErrorModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      message = json['message'];
    } else {
      // Provide default values or handle the situation accordingly.
      message = "Unknown Error";
    }
  }

}