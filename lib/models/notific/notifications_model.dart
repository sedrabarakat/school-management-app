class AbsencesModel {

  bool? status;
  List<AbsencesModelData>? absencesList;

  AbsencesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      absencesList = [];
      json['data'].forEach((element) {
        absencesList!.add(AbsencesModelData.fromJson(element));
      });
    }
  }

}


class AbsencesModelData {

  String? date;
  String? name;
  String? dateGood;


  AbsencesModelData.fromJson(Map<String, dynamic> json) {
    date = json['created_at'];
    name = json['name'];
    dateGood = json['date'];
  }

}



class NotificationsModel {

  bool? status;
  List<NotificationsModelData>? notificationsList;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      notificationsList = [];
      json['data'].forEach((element) {
        notificationsList!.add(NotificationsModelData.fromJson(element));
      });
    }
  }

}


class NotificationsModelData {

  String? title;
  String? body;
  String? sender;
  String? date;


  NotificationsModelData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    sender = json['sender'];
    date = json['created_at'];
  }

}