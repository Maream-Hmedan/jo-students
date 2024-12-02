import 'dart:convert';

class NotificationRequest {
  int semesterId;
  int classId;
  int userid;

  NotificationRequest({
    required this.semesterId,
    required this.classId,
    required this.userid,
  });

  NotificationRequest copyWith({
    int? semesterId,
    int? classId,
    int? userid,
  }) =>
      NotificationRequest(
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
        userid: userid ?? this.userid,
      );

  factory NotificationRequest.fromRawJson(String str) => NotificationRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationRequest.fromJson(Map<String, dynamic> json) => NotificationRequest(
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "SemesterID": semesterId,
    "ClassID": classId,
    "userid": userid,
  };
}
