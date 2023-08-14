class StudentProfileModel {
  bool? status;
  StData? data;

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? StData.fromJson(json['data']) : null;
  }
}

class StData {

  StudentData? studentData;
  dynamic absenceRate;
  dynamic marksRate;

  StData.fromJson(Map<String, dynamic> json) {
    studentData = json['student_data'] != null
        ? StudentData.fromJson(json['student_data'])
        : null;
    absenceRate = json['absence_rate'];
    marksRate = json['marks_rate'];
  }

}

class StudentData {

  int? id;
  String? name;
  String? birthDate;
  String? gender;
  String? email;
  String? img;
  String? address;
  String? phoneNumber;
  int? leftForQusat;
  int? isInBus;
  int? leftForBus;
  int? grade;
  int? sectionNumber;

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    email = json['email'];
    img = json['img'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    leftForQusat = json['left_for_qusat'];
    isInBus = json['is_in_bus'];
    leftForBus = json['left_for_bus'];
    grade = json['grade'];
    sectionNumber = json['section_number'];
  }
}



///////////////////////////////////////////////////////////////////////////////

// Teacher

class TeacherProfileModel {
  bool? status;
  TeData? data;

  TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? TeData.fromJson(json['data']) : null;
  }

}

class TeData {
  TeacherInfo? teacherInfo;
  List<Subjects>? subjects;

  TeData.fromJson(Map<String, dynamic> json) {
    teacherInfo = json['teacherInfo'] != null
        ? TeacherInfo.fromJson(json['teacherInfo'])
        : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

}


class TeacherInfo {
  int? id;
  String? name;
  String? img;
  String? phoneNumber;
  int? salary;
  String? gender;
  String? email;

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    phoneNumber = json['phone_number'];
    salary = json['salary'];
    gender = json['gender'];
    email = json['email'];
  }

}

class Subjects {
  int? id;
  String? name;
  int? grade;

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    grade = json['grade'];
  }
}

