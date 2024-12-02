// ignore_for_file: constant_identifier_names

import 'dart:convert';

class MyQuestionResponse {
  String subjectTitle;
  String semesterTitleAr;
  int isHasAnswer;
  String subjectTitleAr;
  String classId;
  String classTitleAr;
  String messageDt;
  String messageText;
  String strMessageShort;
  int studentQuestionId;
  int studentId;

  MyQuestionResponse({
    required this.subjectTitle,
    required this.semesterTitleAr,
    required this.isHasAnswer,
    required this.subjectTitleAr,
    required this.classId,
    required this.classTitleAr,
    required this.messageDt,
    required this.messageText,
    required this.strMessageShort,
    required this.studentQuestionId,
    required this.studentId,
  });

  MyQuestionResponse copyWith({
    String? subjectTitle,
    String? semesterTitleAr,
    int? isHasAnswer,
    String? subjectTitleAr,
    String? classId,
    String? classTitleAr,
    String? messageDt,
    String? messageText,
    String? strMessageShort,
    int? studentQuestionId,
    int? studentId,
  }) =>
      MyQuestionResponse(
        subjectTitle: subjectTitle ?? this.subjectTitle,
        semesterTitleAr: semesterTitleAr ?? this.semesterTitleAr,
        isHasAnswer: isHasAnswer ?? this.isHasAnswer,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        classId: classId ?? this.classId,
        classTitleAr: classTitleAr ?? this.classTitleAr,
        messageDt: messageDt ?? this.messageDt,
        messageText: messageText ?? this.messageText,
        strMessageShort: strMessageShort ?? this.strMessageShort,
        studentQuestionId: studentQuestionId ?? this.studentQuestionId,
        studentId: studentId ?? this.studentId,
      );

  factory MyQuestionResponse.fromRawJson(String str) => MyQuestionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyQuestionResponse.fromJson(Map<String, dynamic> json) => MyQuestionResponse(
    subjectTitle: json["Subject_Title"]??"",
    semesterTitleAr: json["Semester_Title_Ar"]??"",
    isHasAnswer: json["is_has_answer"]??"",
    subjectTitleAr: json["Subject_Title_Ar"]??"",
    classId: json["ClassID"]??"",
    classTitleAr: json["Class_Title_Ar"]??"",
    messageDt: json["MessageDT"]??"",
    messageText: json["MessageText"]??"",
    strMessageShort: json["strMessageShort"]??"",
    studentQuestionId: json["StudentQuestionID"]??"",
    studentId: json["StudentID"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Subject_Title": subjectTitle,
    "Semester_Title_Ar": semesterTitleAr,
    "is_has_answer": isHasAnswer,
    "Subject_Title_Ar": subjectTitleAr,
    "ClassID": classId,
    "Class_Title_Ar": classTitleAr,
    "MessageDT": messageDt,
    "MessageText": messageText,
    "strMessageShort": strMessageShort,
    "StudentQuestionID": studentQuestionId,
    "StudentID": studentId,
  };
}

enum SemesterTitleAr {
  EMPTY
}

final semesterTitleArValues = EnumValues({
  "الفصل الاول": SemesterTitleAr.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
