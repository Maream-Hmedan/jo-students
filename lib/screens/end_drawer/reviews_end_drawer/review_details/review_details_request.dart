import 'dart:convert';

class ReviewDetailsRequest {
  int listId;
  int studentId;
  int classId;
  int semesterId;

  ReviewDetailsRequest({
    required this.listId,
    required this.studentId,
    required this.classId,
    required this.semesterId,
  });

  ReviewDetailsRequest copyWith({
    int? listId,
    int? studentId,
    int? classId,
    int? semesterId,
  }) =>
      ReviewDetailsRequest(
        listId: listId ?? this.listId,
        studentId: studentId ?? this.studentId,
        classId: classId ?? this.classId,
        semesterId: semesterId ?? this.semesterId,
      );

  factory ReviewDetailsRequest.fromRawJson(String str) => ReviewDetailsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewDetailsRequest.fromJson(Map<String, dynamic> json) => ReviewDetailsRequest(
    listId: json["ListID"],
    studentId: json["StudentID"],
    classId: json["ClassID"],
    semesterId: json["SemesterID"],
  );

  Map<String, dynamic> toJson() => {
    "ListID": listId,
    "StudentID": studentId,
    "ClassID": classId,
    "SemesterID": semesterId,
  };
}
