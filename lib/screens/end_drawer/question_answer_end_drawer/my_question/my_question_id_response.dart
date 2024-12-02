import 'dart:convert';

class MyQuestionIdResponse {
  String subjectTitle;
  String semesterTitleAr;
  String answerMessageDt;
  String answerMessageText;
  String subjectTitleAr;
  String classId;
  String messageDt;
  String messageText;
  String strMessageShort;
  int studentQuestionId;
  int studentId;

  MyQuestionIdResponse({
    required this.subjectTitle,
    required this.semesterTitleAr,
    required this.answerMessageDt,
    required this.answerMessageText,
    required this.subjectTitleAr,
    required this.classId,
    required this.messageDt,
    required this.messageText,
    required this.strMessageShort,
    required this.studentQuestionId,
    required this.studentId,
  });

  MyQuestionIdResponse copyWith({
    String? subjectTitle,
    String? semesterTitleAr,
    String? answerMessageDt,
    String? answerMessageText,
    String? subjectTitleAr,
    String? classId,
    String? messageDt,
    String? messageText,
    String? strMessageShort,
    int? studentQuestionId,
    int? studentId,
  }) =>
      MyQuestionIdResponse(
        subjectTitle: subjectTitle ?? this.subjectTitle,
        semesterTitleAr: semesterTitleAr ?? this.semesterTitleAr,
        answerMessageDt: answerMessageDt ?? this.answerMessageDt,
        answerMessageText: answerMessageText ?? this.answerMessageText,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        classId: classId ?? this.classId,
        messageDt: messageDt ?? this.messageDt,
        messageText: messageText ?? this.messageText,
        strMessageShort: strMessageShort ?? this.strMessageShort,
        studentQuestionId: studentQuestionId ?? this.studentQuestionId,
        studentId: studentId ?? this.studentId,
      );

  factory MyQuestionIdResponse.fromRawJson(String str) => MyQuestionIdResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyQuestionIdResponse.fromJson(Map<String, dynamic> json) => MyQuestionIdResponse(
    subjectTitle: json["Subject_Title"]??"",
    semesterTitleAr: json["Semester_Title_Ar"]??"",
    answerMessageDt: json["Answer_MessageDT"]??"",
    answerMessageText: json["Answer_MessageText"]??"",
    subjectTitleAr: json["Subject_Title_Ar"]??"",
    classId: json["ClassID"]??"",
    messageDt: json["MessageDT"]??"",
    messageText: json["MessageText"]??"",
    strMessageShort: json["strMessageShort"]??"",
    studentQuestionId: json["StudentQuestionID"]??"",
    studentId: json["StudentID"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Subject_Title": subjectTitle,
    "Semester_Title_Ar": semesterTitleAr,
    "Answer_MessageDT": answerMessageDt,
    "Answer_MessageText": answerMessageText,
    "Subject_Title_Ar": subjectTitleAr,
    "ClassID": classId,
    "MessageDT": messageDt,
    "MessageText": messageText,
    "strMessageShort": strMessageShort,
    "StudentQuestionID": studentQuestionId,
    "StudentID": studentId,
  };
}
