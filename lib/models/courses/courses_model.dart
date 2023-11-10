class GetSessionsModel {
  bool? status;
  List<SessionData>? data;

  GetSessionsModel({this.status, this.data});

  GetSessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SessionData>[];
      json['data'].forEach((v) {
        data!.add(new SessionData.fromJson(v));
      });
    }
  }

}

class SessionData {
  int? sessionId;
  String? date;
  String? body;
  int? maximumStudents;
  int? currentBooked;
  int? price;
  String? teacherName;
  String? subjectName;

  SessionData(
      {this.sessionId,
        this.date,
        this.body,
        this.maximumStudents,
        this.currentBooked,
        this.price,
        this.teacherName,
        this.subjectName});

  SessionData.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    date = json['date'];
    body = json['body'];
    maximumStudents = json['maximum_students'];
    currentBooked = json['current_booked'];
    price = json['price'];
    teacherName = json['teacher_name'];
    subjectName = json['subject_name'];
  }

}