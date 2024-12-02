import 'dart:convert';

class MyReviewsListRequest {
  int studentId;
  int classid;
  int semesterId;

  MyReviewsListRequest({
    required this.studentId,
    required this.classid,
    required this.semesterId,
  });

  MyReviewsListRequest copyWith({
    int? studentId,
    int? classid,
    int? semesterId,
  }) =>
      MyReviewsListRequest(
        studentId: studentId ?? this.studentId,
        classid: classid ?? this.classid,
        semesterId: semesterId ?? this.semesterId,
      );

  factory MyReviewsListRequest.fromRawJson(String str) => MyReviewsListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyReviewsListRequest.fromJson(Map<String, dynamic> json) => MyReviewsListRequest(
    studentId: json["StudentID"],
    classid: json["Classid"],
    semesterId: json["SemesterID"],
  );

  Map<String, dynamic> toJson() => {
    "StudentID": studentId,
    "Classid": classid,
    "SemesterID": semesterId,
  };
}
