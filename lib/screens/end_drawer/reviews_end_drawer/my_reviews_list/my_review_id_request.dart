import 'dart:convert';

class MyReviewIdRequest {
  int listId;
  int studentId;
  int classid;
  int semesterId;

  MyReviewIdRequest({
    required this.listId,
    required this.studentId,
    required this.classid,
    required this.semesterId,
  });

  MyReviewIdRequest copyWith({
    int? listId,
    int? studentId,
    int? classid,
    int? semesterId,
  }) =>
      MyReviewIdRequest(
        listId: listId ?? this.listId,
        studentId: studentId ?? this.studentId,
        classid: classid ?? this.classid,
        semesterId: semesterId ?? this.semesterId,
      );

  factory MyReviewIdRequest.fromRawJson(String str) => MyReviewIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyReviewIdRequest.fromJson(Map<String, dynamic> json) => MyReviewIdRequest(
    listId: json["ListID"],
    studentId: json["StudentID"],
    classid: json["Classid"],
    semesterId: json["SemesterID"],
  );

  Map<String, dynamic> toJson() => {
    "ListID": listId,
    "StudentID": studentId,
    "Classid": classid,
    "SemesterID": semesterId,
  };
}
