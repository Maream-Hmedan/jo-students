import 'dart:convert';

class NotificationResponse {
  String notiUrl;
  int semesterId;
  String studentNotificationId;
  int classId;
  String notificationText;
  String notiDt;
  String notiIcon;

  NotificationResponse({
    required this.notiUrl,
    required this.semesterId,
    required this.studentNotificationId,
    required this.classId,
    required this.notificationText,
    required this.notiDt,
    required this.notiIcon,
  });

  NotificationResponse copyWith({
    String? notiUrl,
    int? semesterId,
    String? studentNotificationId,
    int? classId,
    String? notificationText,
    String? notiDt,
    String? notiIcon,
  }) =>
      NotificationResponse(
        notiUrl: notiUrl ?? this.notiUrl,
        semesterId: semesterId ?? this.semesterId,
        studentNotificationId: studentNotificationId ?? this.studentNotificationId,
        classId: classId ?? this.classId,
        notificationText: notificationText ?? this.notificationText,
        notiDt: notiDt ?? this.notiDt,
        notiIcon: notiIcon ?? this.notiIcon,
      );

  factory NotificationResponse.fromRawJson(String str) => NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    notiUrl: json["Noti_url"]??'',
    semesterId: json["SemesterID"]??'',
    studentNotificationId: json["Student_NotificationID"]??'',
    classId: json["ClassID"]??'',
    notificationText: json["NotificationText"]??'',
    notiDt: json["NotiDT"]??'',
    notiIcon: json["Noti_Icon"]??'',
  );

  Map<String, dynamic> toJson() => {
    "Noti_url": notiUrl,
    "SemesterID": semesterId,
    "Student_NotificationID": studentNotificationId,
    "ClassID": classId,
    "NotificationText": notificationText,
    "NotiDT": notiDt,
    "Noti_Icon": notiIcon,
  };
}
