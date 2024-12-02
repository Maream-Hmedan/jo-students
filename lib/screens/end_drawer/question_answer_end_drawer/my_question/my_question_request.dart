import 'dart:convert';

class MyQuestionRequest {
  int studentId;

  MyQuestionRequest({
    required this.studentId,
  });

  MyQuestionRequest copyWith({
    int? studentId,
  }) =>
      MyQuestionRequest(
        studentId: studentId ?? this.studentId,
      );

  factory MyQuestionRequest.fromRawJson(String str) => MyQuestionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyQuestionRequest.fromJson(Map<String, dynamic> json) => MyQuestionRequest(
    studentId: json["StudentID"],
  );

  Map<String, dynamic> toJson() => {
    "StudentID": studentId,
  };
}
