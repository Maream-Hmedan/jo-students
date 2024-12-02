import 'dart:convert';

class MyQuestionIdRequest {
  int questionId;
  int studentId;

  MyQuestionIdRequest({
    required this.questionId,
    required this.studentId,
  });

  MyQuestionIdRequest copyWith({
    int? questionId,
    int? studentId,
  }) =>
      MyQuestionIdRequest(
        questionId: questionId ?? this.questionId,
        studentId: studentId ?? this.studentId,
      );

  factory MyQuestionIdRequest.fromRawJson(String str) => MyQuestionIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyQuestionIdRequest.fromJson(Map<String, dynamic> json) => MyQuestionIdRequest(
    questionId: json["QuestionID"],
    studentId: json["StudentID"],
  );

  Map<String, dynamic> toJson() => {
    "QuestionID": questionId,
    "StudentID": studentId,
  };
}
