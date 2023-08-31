class HomeworkModel {

  bool? status;
  List<HomeworkModelData>? homeworksList;

  HomeworkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      homeworksList = [];
      json['data'].forEach((element) {
        homeworksList!.add(HomeworkModelData.fromJson(element));
      });
    }
  }

}


class HomeworkModelData {

  String? subject;
  String? teacher_name;
  String? body;
  String? file;
  String? date;


  HomeworkModelData.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    teacher_name = json['teacher_name'];
    body = json['body'];
    file = json['file'] ?? '';
    date = json['created_at'];
  }

}