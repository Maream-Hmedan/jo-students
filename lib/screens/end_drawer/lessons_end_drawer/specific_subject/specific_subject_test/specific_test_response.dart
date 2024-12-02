import 'dart:convert';

class BooksTestResponse {
  String examPeriod;
  String examTItle;
  String numberOfQuestions;
  String examHid;
  String examDescription;

  BooksTestResponse({
    required this.examPeriod,
    required this.examTItle,
    required this.numberOfQuestions,
    required this.examHid,
    required this.examDescription,
  });

  BooksTestResponse copyWith({
    String? examPeriod,
    String? examTItle,
    String? numberOfQuestions,
    String? examHid,
    String? examDescription,
  }) =>
      BooksTestResponse(
        examPeriod: examPeriod ?? this.examPeriod,
        examTItle: examTItle ?? this.examTItle,
        numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
        examHid: examHid ?? this.examHid,
        examDescription: examDescription ?? this.examDescription,
      );

  factory BooksTestResponse.fromRawJson(String str) => BooksTestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksTestResponse.fromJson(Map<String, dynamic> json) => BooksTestResponse(
    examPeriod: json["Exam_Period"]??"",
    examTItle: json["ExamTItle"]??"",
    numberOfQuestions: json["NumberOfQuestions"]??"",
    examHid: json["ExamHID"]??"",
    examDescription: json["ExamDescription"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Exam_Period": examPeriod,
    "ExamTItle": examTItle,
    "NumberOfQuestions": numberOfQuestions,
    "ExamHID": examHid,
    "ExamDescription": examDescription,
  };
}
