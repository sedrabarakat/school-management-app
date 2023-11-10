class HomeModel {

  bool? status;
  HomeUserModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeUserModel.fromJson(json['data']) : null;
  }

}

class HomeUserModel {

  HomeDataModel? user;

  HomeUserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? HomeDataModel.fromJson(json['user']) : null;
  }

}

class HomeDataModel {

  String? name;
  String? img;
  int? grade;
  int? section_number;
  List<ChildHomeData>? childHomeData;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'] ?? '';
    grade = json['grade'];
    section_number = json['section_number'];

    if (json['childs'] != null) {
      childHomeData = [];
      json['childs'].forEach((element) {
        childHomeData!.add(ChildHomeData.fromJson(element));
      });
    }
    else {
      childHomeData = [];
    }

  }

}


class ChildHomeData {

  String? name;
  String? img;
  int? grade;
  int? section_number;
  int? id;

  ChildHomeData.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    img = json['img'];
    grade = json['grade'];
    section_number = json['section_number'];
    id = json['id'];

  }

}