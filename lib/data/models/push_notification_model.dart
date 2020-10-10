//class PushNotificationModel {
//  Notification notification;
//  Data data;
//
//  PushNotificationModel({this.notification, this.data});
//
//  PushNotificationModel.fromJson(Map<String, dynamic> json) {
//    notification = json['notification'] != null
//        ? new Notification.fromJson(json['notification'])
//        : null;
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.notification != null) {
//      data['notification'] = this.notification.toJson();
//    }
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    return data;
//  }
//}
//
//class Notification {
//  String title;
//  String body;
//
//  Notification({this.title, this.body});
//
//  Notification.fromJson(Map<String, dynamic> json) {
//    title = json['title'];
//    body = json['body'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['title'] = this.title;
//    data['body'] = this.body;
//    return data;
//  }
//}
//
//class Data {
//  Data data;
//  String clickAction;
//
//  Data({this.data, this.clickAction});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//    clickAction = json['click_action'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['click_action'] = this.clickAction;
//    return data;
//  }
//}
//
//class Data {
//  String artistid;
//  String videoid;
//
//  Data({this.artistid, this.videoid});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    artistid = json['artistid'];
//    videoid = json['videoid'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['artistid'] = this.artistid;
//    data['videoid'] = this.videoid;
//    return data;
//  }
//}