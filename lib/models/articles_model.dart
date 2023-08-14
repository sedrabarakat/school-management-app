class ArticlesModel {
  bool? status;
  String? message;
  ArticlesListModel? data;

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? ArticlesListModel.fromJson(json['data']) : null;
  }
}

class ArticlesListModel {
  int? lastPageNumber;
  List<ArticleData>? articlesList;

  ArticlesListModel.fromJson(Map<String, dynamic> json) {
    lastPageNumber = json['lastPageNumber'];

    if (json['data'] != null) {
      articlesList = [];
      json['data'].forEach((element) {
        articlesList!.add(ArticleData.fromJson(element));
      });
    }
  }
}

class ArticleData {
  int? article_id;
  String? title;
  String? body;
  String? name;
  dynamic is_media;
  String? media;
  String? role;
  dynamic imgPerson;
  String? date;

  ArticleData.fromJson(Map<String, dynamic> json) {
    article_id = json['id'];
    title = json['title'];
    body = json['body'];
    name = json['name'];
    is_media = json['is_img'];

    if (json['media'] == null) {
      media = '';
    }
    else {
      media = json['media'];
    }
    role = json['role'];

    if (json['img'] == null) {
      imgPerson = '';
    }
    else {
      imgPerson = json['img'];
    }

    date = json['created_at'];

  }
}