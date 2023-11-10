class MarksModel {
  String? message;
  MarksData? data;

  MarksModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];

    data = json['data'] != null ? MarksData.fromJson(json['data']) : null;
  }
}

class MarksData {
  int? percentage;
  List<MarksStudentData>? marksStudentData;

  MarksData.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    if (json['marks'] != null) {
      marksStudentData = [];
      json['marks'].forEach((element) {
        marksStudentData!.add(MarksStudentData.fromJson(element));
      });
    }
  }
}

class MarksStudentData {
  String? sub_name;
  String? exam_type;
  int? mark;
  String? date;

  MarksStudentData.fromJson(Map<String, dynamic> json) {
    sub_name = json['sub_name'];
    exam_type = json['exam_type'];
    mark = json['mark'];
    date = json['created_at'];
  }
}
